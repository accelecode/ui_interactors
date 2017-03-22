require 'interlock_automation/interlock_test/minitest'
require_relative 'ui_steps'

class BaseTest < InterlockTest

  attr_reader :ui_steps

  def setup
    super
    @ui_steps ||= UiSteps.new(driver)
  end

end
