require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Amp::Core::RepositoryLoading do
  describe "#has_repo" do
    before do
      @class_with = Class.new(Amp::Command::Base) do
        has_repo
      end
      @class_without = Class.new(Amp::Command::Base) do
      end
    end
    
    it "includes the module in a Command when it called" do
      @class_with.included_modules.should
          include(Amp::Core::RepositoryLoading)
    end
  
    it "doesn't include the module in a Command when not called" do
      @class_without.included_modules.should_not
          include(Amp::Core::RepositoryLoading)
    end
  
    it "extends the new class with ClassMethods when called" do
      (class << @class_with; self; end).included_modules.should
          include(Amp::Core::RepositoryLoading::ClassMethods)
    end

    it "doesn't extend the new class with ClassMethods when not called" do
      (class << @class_without; self; end).included_modules.should_not
          include(Amp::Core::RepositoryLoading::ClassMethods)
    end

    it "includes the new class with InstanceMethods when called" do
      @class_with.included_modules.should
          include(Amp::Core::RepositoryLoading::InstanceMethods)
    end

    it "doesn't include the new class with InstanceMethods when not called" do
      @class_without.included_modules.should_not
          include(Amp::Core::RepositoryLoading::InstanceMethods)
    end
    
    it "doesn't ever modify Amp::Command::Base" do
      Amp::Command::Base.included_modules.should_not
          include(Amp::Core::RepositoryLoading)
      Amp::Command::Base.included_modules.should_not
          include(Amp::Core::RepositoryLoading::InstanceMethods)
      (class << Amp::Command::Base; self; end).included_modules.should_not
          include(Amp::Core::RepositoryLoading::ClassMethods)
    end
    
    it "adds a :repository option when called" do
      opts = @class_with.options
      repo_opt = opts.find {|name, desc, config| name == :repository }
      repo_opt.should_not be_nil
    end
    
    it "lacks a :repository option when not called" do
      opts = @class_without.options
      repo_opt = opts.find {|name, desc, config| name == :repository }
      repo_opt.should be_nil
    end
  end
end