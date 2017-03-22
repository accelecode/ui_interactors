require_relative '../base_test'

class TestActionInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').view('first-navigation').action('navigate').is_visible!
  end

  def test_is_not_visible!
    view('home').view('first-navigation').action('action-that-does-not-exist').is_not_visible!
  end

  def test_activate
    view('home').view('first-navigation').action('navigate').activate
    view('home').is_not_visible!
    view('another-section').is_visible!
  end

end
