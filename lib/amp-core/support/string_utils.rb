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
          ##
          # Converts a string of hex into the binary values it represents. This is used for
          # when we store a node ID in a human-readable format, and need to convert it back.
          #
          # @example "DEADBEEF".unhexlify #=> "\336\255\276\357"
          # @return [String] the string decoded from hex form
          def unhexlify(src)
            str = "\000" * (src.size/2)
            c = 0
            (0..src.size-2).step(2) do |i|
              hex = src[i,2].to_i(16)
              str[c] = hex
              c += 1
            end
            str
          end
        else
          # Returns the value of the first byte of the string.
          #
          # @return [Fixnum, 0 <= x < 256] The value of the first byte.
          def ord(str)
            raise ArgumentError.new('empty string') if str.empty?
            str.ord
          end

          def unhexlify(str)
            str = "\000" * (src.size/2)
            c = 0
            (0..src.size-2).step(2) do |i|
              hex = src[i,2].to_i(16)
              str[c] = hex.chr
              c += 1
            end
            str
          end
        end
        
        def sha1(str)
          Digest::SHA1.new.update(str)
        end
      end
    end
  end
end