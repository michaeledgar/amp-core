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
      # This module is used to set a few constants regarding which OS,
      # implementation, and architecture the user is running.
      module Platform
        if RUBY_PLATFORM =~ /darwin/i
          OS = :unix
          IMPL = :macosx
        elsif RUBY_PLATFORM =~ /linux/i
          OS = :unix
          IMPL = :linux
        elsif RUBY_PLATFORM =~ /freebsd/i
          OS = :unix
          IMPL = :freebsd
        elsif RUBY_PLATFORM =~ /netbsd/i
          OS = :unix
          IMPL = :netbsd
        elsif RUBY_PLATFORM =~ /mswin/i
          OS = :win32
          IMPL = :mswin
        elsif RUBY_PLATFORM =~ /cygwin/i
          OS = :unix
          IMPL = :cygwin
        elsif RUBY_PLATFORM =~ /mingw/i
          OS = :win32
          IMPL = :mingw
        elsif RUBY_PLATFORM =~ /bccwin/i
          OS = :win32
          IMPL = :bccwin
        elsif RUBY_PLATFORM =~ /wince/i
          OS = :win32
          IMPL = :wince
        elsif RUBY_PLATFORM =~ /vms/i
          OS = :vms
          IMPL = :vms
        elsif RUBY_PLATFORM =~ /os2/i
          OS = :os2
          IMPL = :os2 # maybe there is some better choice here?
        else
          OS = :unknown
          IMPL = :unknown
        end
  
        if RUBY_PLATFORM =~ /(i\d86)/i
          ARCH = :x86
        elsif RUBY_PLATFORM =~ /(x86_64|amd64)/i
          ARCH = :x86_64
        elsif RUBY_PLATFORM =~ /ia64/i
          ARCH = :ia64
        elsif RUBY_PLATFORM =~ /powerpc/i
          ARCH = :powerpc
        elsif RUBY_PLATFORM =~ /alpha/i
          ARCH = :alpha
        elsif RUBY_PLATFORM =~ /universal/i
          ARCH = :universal
        else
          ARCH = :unknown
        end
        SYSTEM = {}
        
        # Figures up the system is running on a little or big endian processor
        # architecture, and upates the SYSTEM[] hash in the Support module.
        def self.determine_endianness
          num = 0x12345678
          native = [num].pack('l')
          netunpack = native.unpack('N')[0]
          if num == netunpack
            SYSTEM[:endian] = :big
          else
            SYSTEM[:endian] = :little
          end   
        end

        determine_endianness
      end
    end
  end
end