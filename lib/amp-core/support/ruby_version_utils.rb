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
module Amp
  module Core
    module Support
      module RubyVersionUtils
        module_function
        
        def ruby_19?
          RUBY_VERSION >= "1.9"
        end
        ##
        # Returns the mode to use for binary streams with a given mode. Needed because
        # of Ruby 1.9 encoding confusion.
        #
        # @param [String] mode the mode to use for IO
        # @return [String] an encoded mode for use with IO
        def binary_mode(mode)
          ruby_19? ? "#{mode}:ASCII-8BIT" : mode
        end
      end
    end
  end
end