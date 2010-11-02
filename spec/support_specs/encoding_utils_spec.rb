##################################################################
#                  Licensing Information                         #
#                                                                #
#  The following code is licensed, as standalone code, under     #
#  the Ruby License, unless otherwise directed within the code.  #
#                                                                #
#  For information on the license of this code when distributed  #
#  with and used in conjunction with the other modules in the    #
#  Amp project, please see the root-level LICENSE file.          #
#                                                                #
#  © Michael J. Edgar and Ari Brown, 2009-2010                   #
#                                                                #
##################################################################

require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Amp::Core::Support::EncodingUtils do
  describe '#network_to_host_64' do
    context 'when little-endian' do
      before(:each) do
        @old_endian = Amp::Core::Support::Platform::SYSTEM[:endian]
        Amp::Core::Support::Platform::SYSTEM[:endian] = :little
      end
      
      after(:each) do
        Amp::Core::Support::Platform::SYSTEM[:endian] = @old_endian
      end
      
      it 'returns the integer with all 8 of its swapped to the n-1 position' do
        input = 0xaabbccddeeff0011
        output = 0x1100ffeeddccbbaa
        Amp::Core::Support::EncodingUtils.network_to_host_64(input).should == output
        Amp::Core::Support::EncodingUtils.network_to_host_64(output).should == input
      end

      it 'returns the integer with all 8 of its swapped to the n-1 position again' do
        input = 0x0123456789abcdef
        output = 0xefcdab8967452301
        Amp::Core::Support::EncodingUtils.network_to_host_64(input).should == output
        Amp::Core::Support::EncodingUtils.network_to_host_64(output).should == input
      end
    end
    
    context 'when big-endian' do
      before(:each) do
        @old_endian = Amp::Core::Support::Platform::SYSTEM[:endian]
        Amp::Core::Support::Platform::SYSTEM[:endian] = :big
      end
      
      after(:each) do
        Amp::Core::Support::Platform::SYSTEM[:endian] = @old_endian
      end
      
      it 'does nothing' do
        input = 0xaabbccddeeff0011
        output = 0xaabbccddeeff0011
        Amp::Core::Support::EncodingUtils.network_to_host_64(input).should == output
        Amp::Core::Support::EncodingUtils.network_to_host_64(output).should == input
      end

      it 'continues to do nothing' do
        input = 0x0123456789abcdef
        output = 0x0123456789abcdef
        Amp::Core::Support::EncodingUtils.network_to_host_64(input).should == output
        Amp::Core::Support::EncodingUtils.network_to_host_64(output).should == input
      end
    end
  end
end
