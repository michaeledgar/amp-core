module Amp
  module Core
    module RepositoryLoading
      def self.included(klass)
        klass.__send__(:extend, ClassMethods)
        klass.__send__(:include, InstanceMethods)
      end
      module ClassMethods

      end
      module InstanceMethods

      end
    end
  end

  class Command
    def self.has_repo
      include Core::RepositoryLoading
    end
  end
end