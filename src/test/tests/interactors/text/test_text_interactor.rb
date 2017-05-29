require_relative '../../base_test'

class TestTextInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    text('section-name').is_visible!
  end

  def test_is_not_visible!
    text('element-that-does-not-exist').is_not_visible!
  end

  def test_has_text!
    text('section-name').has_text!('Home')
  end

  def test_does_not_have_text!
    text('section-name').does_not_have_text!('Home2')
  end

end
