require 'interactor_ui_automation/minitest/interactor_test'
require 'minitest/hooks/test'
require_relative 'ui_steps'

class BaseTest < InteractorUIAutomation::InteractorTest
  include Minitest::Hooks

  attr_reader :ui_steps

  def before_all
    super
    @@driver = Selenium::WebDriver.for(:chrome)
  end

  def after_all
    super
    @@driver.quit
  end

  def setup
    super
    @ui_steps ||= UiSteps.new(driver, root_view)
  end

  def provide_driver
    @@driver
  end

end
