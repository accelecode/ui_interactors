require_relative '../../base_test'

class TestListInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    list('people').is_visible!
  end

  def test_is_not_visible!
    list('list-that-does-not-exist').is_not_visible!
  end

end
