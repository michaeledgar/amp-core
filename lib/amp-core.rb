puts "Loading amp-core..."

require 'amp-core/command_ext/repository_loading'
require 'amp-core/repository/repository.rb'
require 'amp-core/repository/generic_repo_picker.rb'
require 'amp-core/commands/root.rb'
module Amp
  module Support
    autoload :Template,       'amp-core/templates/template.rb'
  end
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
      autoload :EncodingUtils,  'amp-core/support/encoding_utils.rb'
      autoload :Platform,       'amp-core/support/platform_utils.rb'
      autoload :RootedOpener,   'amp-core/support/rooted_opener.rb'
      autoload :HexString,      'amp-core/support/hex_string.rb'
    end
  end
end
