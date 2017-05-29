require_relative '../../base_test'

class TestTextInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').view('heading').view('title').text('section-name').is_visible!
  end

  def test_is_not_visible!
    view('home').view('heading').view('title').text('element-that-does-not-exist').is_not_visible!
  end

  def test_has_text!
    view('home').view('heading').view('title').text('section-name').has_text!('Home')
  end

  def test_does_not_have_text!
    view('home').view('heading').view('title').text('section-name').does_not_have_text!('Home2')
  end

end
