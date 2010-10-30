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
        def repository
          path = options[:repository]
          # pick a repo based on this
          
        end
      end
    end
  end

  module Command
    class Base
      def self.has_repo
        include Core::RepositoryLoading
        opt :repository, "The path to the repository to use", :short => "-R", :default => Dir.pwd
      end
    end
  end
end