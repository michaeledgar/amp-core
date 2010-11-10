$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require '../amp-front/lib/amp-front'
require 'amp-core/amp_plugin'

describe "plugin" do
  it "should have a plugin constant: Amp::Plugins::Core" do
    result = nil
    Amp::Plugins.class_eval do
      result = const_defined?(:Core)
    end
    result.should be_true
  end

  it 'should load the plugin' do
    plugin = Amp::Plugins::Core.new
    # this is entirely too white-box, but other tests already loaded everything
    # mucking with the environment would be kind of messy
    plugin.should_receive(:require)
    plugin.load!
  end
end