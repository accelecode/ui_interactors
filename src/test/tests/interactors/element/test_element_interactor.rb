require_relative '../../base_test'

class TestElementInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    element('section-name').is_visible!
  end

  def test_is_not_visible!
    element('element-that-does-not-exist').is_not_visible!
  end

  def test_has_text!
    element('section-name').has_text!('Home')
  end

  def test_does_not_have_text!
    element('section-name').does_not_have_text!('Home2')
  end

end
