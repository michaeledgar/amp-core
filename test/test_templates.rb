##################################################################
#                  Licensing Information                         #
#                                                                #
#  The following code is licensed, as standalone code, under     #
#  the Ruby License, unless otherwise directed within the code.  #
#                                                                #
#  For information on the license of this code when distributed  #
#  with and used in conjunction with the other modules in the    #
#  Amp project, please see the root-level LICENSE file.          #
#                                                                #
#  © Michael J. Edgar and Ari Brown, 2009-2010                   #
#                                                                #
##################################################################

require 'test/unit'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'amp-front'
require 'amp-core'
Amp::Plugins::Core.new.load!

class TestTemplates < Test::Unit::TestCase
  include Amp::Support
  
  def setup
    @template = Template.new(:log, :test, :erb, "<%= name %> <%= age %>")
    @hamltemplate = Template.new(:commit, :silly, :haml, "= name\n==Age: \#{age}")
  end
  
  def test_new_template
    assert @template
    assert Template[:log, :test]
  end
  
  def test_unregister
    Template.unregister(:log, :test)
    assert_nil(Template[:log, :test])
  end
  
  # ERb Support
  
  def test_render
    name = "Steve"
    age = 21
    assert_equal "Steve 21", @template.render({}, binding)
  end
  
  def test_locals
    locals = {:name => "Steve", :age => 21}
    assert_equal "Steve 21", @template.render(locals)
  end
  
  # Haml support
  
  def test_haml_render
    name = "Steve"
    age = 21
    assert_equal "Steve\nAge: 21", @hamltemplate.render({}, binding).strip
  end
  
  def test_haml_locals
    locals = {:name => "Steve", :age => 21}
    assert_equal "Steve\nAge: 21", @hamltemplate.render(locals).strip
  end
  
  # RawTemplates
  def test_raw_template
    locals = {:name => "Steve", :age => 21}
    assert_equal "Steve 21", RawERbTemplate.new("name + ' ' + age.to_s").render(locals)
  end
  
  # Indirectly tests FileTemplate
  def test_loading_defaults
    Template.ensure_templates_loaded
    assert Template.templates_loaded?
    assert_not_nil(Template[:mercurial, "default-commit"])
    assert_not_nil(Template[:mercurial, "default-log"])
  end
    
end
