require 'minitest/autorun'
require 'forwardable'
require 'selenium-webdriver'
require 'interlock_automation/interactor/view_interactor'

class InterlockTest < Minitest::Test
  extend Forwardable

  attr_reader :driver, :root_view

  def setup
    super
    @driver ||= Selenium::WebDriver.for(:chrome)
    @root_view = InterlockAutomation::Interactor::ViewInteractor.new(@driver)
  end

  def teardown
    super
    driver.quit
  end

  def_delegators :root_view, :view, :action, :element, :text_field, :dropdown_field

end
