class Amp::Plugins::Core < Amp::Plugins::Base
  def initialize(opts={})
    @opts = opts
  end
  
  def load!
    puts "Loading amp-core..."
    require 'amp-core/command_ext/repository_loading'
    require 'amp-core/repository/repository.rb'
    require 'amp-core/repository/generic_repo_picker.rb'
  end
end
