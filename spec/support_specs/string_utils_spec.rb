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

describe Amp::Core::Support::StringUtils do
  describe '#ord' do
    it 'raises an ArgumentError on an empty string' do
      lambda { Amp::Core::Support::StringUtils.ord('') }.should raise_error(ArgumentError)
    end
    
    it 'returns the first byte of the string' do
      Amp::Core::Support::StringUtils.ord('A').should == 65
      Amp::Core::Support::StringUtils.ord('™').should == 226
    end
  end
  
  describe '#unhexlify' do
    it 'converts a few hex bytes to binary' do
      Amp::Core::Support::StringUtils.unhexlify('abcd').should == "\xab\xcd"
    end
  end
  
  describe '#hexlify' do
    it 'converts text data to its hex form' do
      Amp::Core::Support::StringUtils.hexlify('ABCD').should == '41424344'
    end
    
    it 'converts binary data to its hex form' do
      Amp::Core::Support::StringUtils.hexlify('ABCD').should == '41424344'
    end
  end
end
