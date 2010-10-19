class Amp::Plugins::Core < Amp::Plugins::Base
  def initialize(opts)
    @opts = opts
  end
  
  def load!
    puts "Loading amp-core..."
  end
end