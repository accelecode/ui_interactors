require_relative '../../base_test'

class TestListInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').list('people').is_visible!
  end

  def test_is_not_visible!
    view('home').list('list-that-does-not-exist').is_not_visible!
  end

end
