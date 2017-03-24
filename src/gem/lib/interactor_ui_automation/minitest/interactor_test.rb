require 'minitest/autorun'
require 'forwardable'
require 'selenium-webdriver'
require 'interactor_ui_automation'

module InteractorUIAutomation class InteractorTest < Minitest::Test
  extend Forwardable

  attr_reader :driver, :root_view

  def setup
    super
    @driver ||= Selenium::WebDriver.for(:chrome)
    @root_view = InteractorUIAutomation::Interactor::ViewInteractor.new(@driver)
  end

  def teardown
    super
    driver.quit
  end

  def_delegators :root_view, :view, :action, :element, :list, :text_field, :dropdown_field, :checkbox_field

end end
