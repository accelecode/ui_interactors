require 'ui_interactors/minitest/interactor_test'
require_relative 'driver_provider'
require_relative 'ui_steps'

class BaseTest < UiInteractors::InteractorTest
  attr_reader :ui_steps

  def setup
    super
    @ui_steps ||= UiSteps.new(driver, root_view)
    @ui_steps.navigate_to_reset
  end

  def provide_driver
    DriverProvider.instance.driver
  end

end
