require_relative '../base_test'

class TestViewInteractorMultiLevel < BaseTest

  def test_is_visible!
    ui_steps.navigate_to_home
    view('home').view('heading').view('title').is_visible!
  end

  def test_is_not_visible!
    ui_steps.navigate_to_home
    view('home').view('heading').view('view-that-does-not-exist').is_not_visible!
  end

end
