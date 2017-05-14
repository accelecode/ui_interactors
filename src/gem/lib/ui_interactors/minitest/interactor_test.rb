require 'minitest/autorun'
require 'forwardable'
require 'selenium-webdriver'
require 'ui_interactors'

module UiInteractors class InteractorTest < Minitest::Test
  extend Forwardable

  attr_reader :driver, :root_view

  def setup
    super
    @driver = provide_driver
    @root_view = UiInteractors::Interactors::ViewInteractor.new(@driver)
  end

  def_delegators :root_view, :view, :action, :element, :list, :text_field, :dropdown_field, :checkbox_field

  def provide_driver
    raise('Subclass must define `#provide_driver()`')
  end

end end
