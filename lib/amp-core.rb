module Amp
  module Core
  end
  module Support
  end
end

class Amp::Plugins::Core < Amp::Plugins::Base
  def initialize(opts={})
    @opts = opts
  end
  
  def load!
    require 'amp-core/on_load'
  end
end
