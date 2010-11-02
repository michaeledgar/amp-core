module Amp
  module Core
  end
  module Support
  end
end

class Amp::Plugins::Core < Amp::Plugins::Base
  # this is necessary to prevent loading when #load! isn't called.
  @loader = lambda {
    module ::Amp
      module Core
        module Repositories
          autoload :GenericRepoPicker,         'amp-core/repository/generic_repo_picker.rb'
          autoload :AbstractLocalRepository,   'amp-core/repository/abstract/abstract_local_repo.rb'
          autoload :AbstractStagingArea,       'amp-core/repository/abstract/abstract_staging_area.rb'
          autoload :AbstractChangeset,         'amp-core/repository/abstract/abstract_changeset.rb'
          autoload :AbstractVersionedFile,     'amp-core/repository/abstract/abstract_versioned_file.rb'
          autoload :CommonChangesetMethods,    'amp-core/repository/abstract/common_methods/changeset.rb'
          autoload :CommonLocalRepoMethods,    'amp-core/repository/abstract/common_methods/local_repo.rb'
          autoload :CommonStagingAreaMethods,  'amp-core/repository/abstract/common_methods/staging_area.rb'
          autoload :CommonChangesetMethods,    'amp-core/repository/abstract/common_methods/changeset.rb'
          autoload :CommonVersionedFileMethods,'amp-core/repository/abstract/common_methods/versioned_file.rb'
        end
        module Support
          autoload :RootedOpener, 'amp-core/support/rooted_opener.rb'
      end
    end
  }
  class << self
    attr_reader :loader
  end

  def initialize(opts={})
    @opts = opts
  end
  
  def load!
    puts "Loading amp-core..."
    require 'amp-core/command_ext/repository_loading'
    require 'amp-core/repository/repository.rb'
    require 'amp-core/repository/generic_repo_picker.rb'
    ::Amp::Support.class_eval do
      autoload :Template,                  "amp-core/templates/template.rb"
    end
    self.class.loader.call
  end
end
