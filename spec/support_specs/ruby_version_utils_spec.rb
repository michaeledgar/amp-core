# encoding: UTF-8
# chosen as something that forces the subject to deal with encodings
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

describe Amp::Core::Support::RubyVersionUtils do
  describe '#ruby_19?' do
    it 'returns whether we are running Ruby 1.9 or not' do
      if RUBY_VERSION >= "1.9"
      then Amp::Core::Support::RubyVersionUtils.ruby_19?.should be_true
      else Amp::Core::Support::RubyVersionUtils.ruby_19?.should be_false
      end
    end
  end
  
  describe '#binary_mode' do
    it 'returns whether we are running Ruby 1.9 or not' do
      result = Amp::Core::Support::RubyVersionUtils.binary_mode('r+')
      if RUBY_VERSION >= "1.9"
      then result.should == "r+:ASCII-8BIT"
      else result.should == 'r+'
      end
    end
  end
end
