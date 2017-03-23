require 'interlock_automation/minitest/interlock_test'
require_relative 'ui_steps'

class BaseTest < InterlockTest

  attr_reader :ui_steps

  def setup
    super
    @ui_steps ||= UiSteps.new(driver, root_view)
  end

end
