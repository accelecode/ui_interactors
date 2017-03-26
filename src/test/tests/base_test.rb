require 'interactor_ui_automation/minitest/interactor_test'
require_relative 'driver_provider'
require_relative 'ui_steps'

class BaseTest < InteractorUIAutomation::InteractorTest
  attr_reader :ui_steps

  def setup
    super
    @ui_steps ||= UiSteps.new(driver, root_view)
  end

  def provide_driver
    DriverProvider.instance.driver
  end

end
