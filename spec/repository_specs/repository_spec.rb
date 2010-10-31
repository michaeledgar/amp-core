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

describe Amp::Core::Repositories do
  describe '#pick' do
    before do
      mock1, mock2, mock3 = mock(:r1), mock(:r2), mock(:r3)
      subklass1 = Class.new(Amp::Core::Repositories::GenericRepoPicker) do
        define_method(:repo_in_dir?) { |path| false }
        define_method(:pick) { |config, path, create| mock1 }
      end
      subklass2 = Class.new(Amp::Core::Repositories::GenericRepoPicker) do
        define_method(:repo_in_dir?) { |path| true }
        define_method(:pick) { |config, path, create| mock2 }
      end
      subklass3 = Class.new(Amp::Core::Repositories::GenericRepoPicker) do
        define_method(:repo_in_dir?) { |path| true }
        define_method(:pick) { |config, path, create| mock3 }
      end
      @expected = mock2
    end

    it 'Picks the first loaded Repository type to match.' do
      Amp::Core::Repositories.pick(nil, nil, false).should == @expected
    end
  end
end
