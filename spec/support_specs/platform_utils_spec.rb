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

describe Amp::Core::Support::Platform do
  it 'has an OS' do
    Amp::Core::Support::Platform.const_defined?(:OS).should be_true
  end
  it 'has an implementation' do
    Amp::Core::Support::Platform.const_defined?(:IMPL).should be_true
  end
  it 'has an architecture' do
    Amp::Core::Support::Platform.const_defined?(:ARCH).should be_true
  end
  it 'has an SYSTEM hash' do
    Amp::Core::Support::Platform.const_defined?(:SYSTEM).should be_true
  end
  it 'has an endianness' do
    Amp::Core::Support::Platform::SYSTEM[:endian].should_not be_nil
  end
end
