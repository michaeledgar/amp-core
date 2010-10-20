require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "amp-core" do
  it "should have a plugin constant: Amp::Plugins::Core" do
    result = nil
    Amp::Plugins.class_eval do
      result = const_defined?(:Core)
    end
    result.should be_true
  end
end