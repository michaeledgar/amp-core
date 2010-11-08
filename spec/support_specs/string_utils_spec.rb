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

describe Amp::Core::Support::HexString do
  Subject = Amp::Core::Support::HexString
  describe 'created from binary data' do
    it 'can be created without error' do
      Subject.from_bin('A').should be_kind_of(Subject)
    end

    describe '#ord' do
      it 'raises an ArgumentError on an empty string' do
        lambda { Subject.from_bin('').ord }.should raise_error(ArgumentError)
      end
      
      it 'returns the first byte of a simple character' do
        Subject.from_bin('A').ord.should == 65
      end

      it 'returns the first byte of a complex character' do
        Subject.from_bin('™').ord.should == 226
      end
    end
    
    describe '#to_bin' do
      it 'maintains itself' do
        Subject.from_bin('abcd').to_bin.should == "abcd"
      end
    end
    
    describe '#to_hex' do
      it 'converts text data to its hex form' do
        Subject.from_bin('ABCD').to_hex.should == '41424344'
      end
    end

    describe '#to_s' do
      it 'same result as to_hex' do
        s = Subject.from_bin('ABCD')
        s.to_s.should == s.to_hex
      end
    end
  end

  describe 'created from hex string' do
    it 'can be created without error' do
      Subject.from_hex('ab').should be_kind_of(Subject)
    end

    describe '#ord' do
      it 'raises an ArgumentError on an empty string' do
        lambda { Subject.new('').ord }.should raise_error(ArgumentError)
      end
      
      it 'returns the first byte of a simple character' do
        Subject.from_hex('41').ord.should == 65
      end

      it 'returns the first byte of a complex character' do
        Subject.from_hex('e2').ord.should == 226
      end
    end
    
    describe '#to_bin' do
      it 'converts a few hex bytes to binary' do
        Subject.from_hex('abcd').to_bin.should == Subject.as_binary("\xab\xcd")
      end
    end
    
    describe '#to_hex' do
      it 'maintains itself' do
        Subject.from_hex('ABCD').to_hex.should == 'ABCD'
      end
    end

    describe '#to_s' do
      it 'same result as to_hex' do
        s = Subject.from_hex('ABCD')
        s.to_s.should == s.to_hex
      end
    end
  end

  describe '::sha1' do
    it 'creates a HexString' do
      Subject.sha1('A').should be_kind_of(Subject)
    end
  end
end
