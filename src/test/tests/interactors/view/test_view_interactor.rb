require_relative '../../base_test'

class TestViewInteractor < BaseTest

  def test_is_visible!
    ui_steps.navigate_to_home
    view('home').is_visible!
  end

  def test_is_not_visible!
    ui_steps.navigate_to_home
    view('view-that-does-not-exist').is_not_visible!
  end

end
