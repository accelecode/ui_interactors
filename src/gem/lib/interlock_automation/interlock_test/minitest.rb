require 'minitest/autorun'
require 'selenium-webdriver'
require 'interlock_automation/interactor/view_interactor'

class InterlockTest < Minitest::Test

  attr_reader :driver

  def setup
    super
    @driver ||= Selenium::WebDriver.for(:chrome)
    @root_view = InterlockAutomation::Interactor::ViewInteractor.new(@driver)
  end

  def teardown
    super
    driver.quit
  end

  def view(name)
    @root_view.view(name)
  end

end
