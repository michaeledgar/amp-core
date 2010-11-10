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
require 'digest'

module Amp
  module Core
    module Support
      # This module is a set of string functions that we use frequently.
      # They sued to be monkey-patched onto the String class, but we don't
      # do that anymore.
      class HexString
        # Construct a HexString
        def self.from_bin(bin)
          new(bin, nil)
        end

        # Construct a HexString
        def self.from_hex(hex)
          new(nil, hex)
        end

        # Mainly internal/test helper method; change the encoding in 1.9
        def self.as_binary(s)
          if s.respond_to?(:force_encoding)
            s.force_encoding('binary')
          else
            s
          end
        end

        def self.sha1(str)
          HexString.from_bin(Digest::SHA1.new.update(str).digest)
        end

        # Assumes one or the other argument will be nil.
        # Mostly an internal constructor
        def initialize(binary_part, hex_part)
          @binary = self.class.as_binary(binary_part)
          @hex = hex_part
        end

        def <=>(other)
          to_s <=> other.to_s
        end
        include Comparable

        # Return raw binary data
        def to_bin
          @binary ||= unhexlify
        end

        # Return hexidecimal representation of binary data
        def to_hex
          @hex ||= hexlify
        end

        # Return hexidecimal representation of binary data
        alias_method :to_s, :to_hex

        # Converts this text into hex. each letter is replaced with
        # it's hex counterpart 
        def hexlify
          hex = ""
          @binary.each_byte do |i|
            hex << i.to_s(16).rjust(2, "0")
          end
          hex
        end
        
        if RUBY_VERSION < "1.9"
          # Returns the value of the first byte of the string.
          #
          # @return [Fixnum, 0 <= x < 256] The value of the first byte.
          def ord
            raise ArgumentError.new('empty string') if to_bin.empty?
            to_bin[0]
          end
          ##
          # Converts a string of hex into the binary values it represents. This is used for
          # when we store a node ID in a human-readable format, and need to convert it back.
          #
          # @example StringUtils.unhexlify("DEADBEEF") #=> "\336\255\276\357"
          # @return [String] the string decoded from hex form
          def unhexlify
            bin = "\000" * (@hex.size/2)
            c = 0
            (0..@hex.size-2).step(2) do |i|
              byte = @hex[i,2].to_i(16)
              bin[c] = byte
              c += 1
            end
            bin
          end
        else
          # Returns the value of the first byte of the string.
          #
          # @return [Fixnum, 0 <= x < 256] The value of the first byte.
          def ord
            to_bin.ord
          end

          def unhexlify
            bin = "\000" * (@hex.size/2)
            c = 0
            (0..@hex.size-2).step(2) do |i|
              byte = @hex[i,2].to_i(16)
              bin[c] = byte.chr
              c += 1
            end
            bin
          end
        end
      end
    end
  end
end