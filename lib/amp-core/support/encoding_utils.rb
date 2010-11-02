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
      module EncodingUtils
        module_function
        
        ##
        # Used for byte-swapping a 64-bit double long.
        # Unfortuantely, this will invoke bignum logic, which is ridiculously slow.
        # That's why we have a C extension.
        # 
        # If the system is little endian, we work some magic. If the system is big
        # endian, we just return self.
        #
        # @return [Integer] the number swapped as if it were a 64-bit integer
        def network_to_host_64(src)
          if Amp::Core::Support::Platform::SYSTEM[:endian] == :little
            ((src >> 56))                      | ((src & 0x00FF000000000000) >> 40) |
            ((src & 0x0000FF0000000000) >> 24) | ((src & 0x000000FF00000000) >> 8 ) |
            ((src & 0x00000000FF000000) << 8 ) | ((src & 0x0000000000FF0000) << 24) |
            ((src & 0x000000000000FF00) << 40) | ((src & 0x00000000000000FF) << 56)
          else
            src
          end
        end
      end
    end
  end
end