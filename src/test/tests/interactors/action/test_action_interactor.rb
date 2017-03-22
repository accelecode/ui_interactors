require_relative '../../base_test'

class TestActionInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    action('navigate-to-another').is_visible!
  end

  def test_is_not_visible!
    action('action-that-does-not-exist').is_not_visible!
  end

  def test_activate
    action('navigate-to-another').activate
    view('home').is_not_visible!
    view('another-section').is_visible!
  end

end
