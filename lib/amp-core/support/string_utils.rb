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
      # This module is a set of string functions that we use frequently.
      # They sued to be monkey-patched onto the String class, but we don't
      # do that anymore.
      module StringUtils
        module_function
        
        if RUBY_VERSION < "1.9"
          # Returns the value of the first byte of the string.
          #
          # @return [Fixnum, 0 <= x < 256] The value of the first byte.
          def ord(str)
            raise ArgumentError.new('empty string') if str.empty?
            str[0]
          end
        else
          # Returns the value of the first byte of the string.
          #
          # @return [Fixnum, 0 <= x < 256] The value of the first byte.
          def ord(str)
            raise ArgumentError.new('empty string') if str.empty?
            str.ord
          end
        end
      end
    end
  end
end