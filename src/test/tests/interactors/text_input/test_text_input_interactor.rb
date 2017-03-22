require_relative '../../base_test'

class TestTextInputInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    text_field('filled').is_visible!
  end

  def test_is_not_visible!
    text_field('text-input-that-does-not-exist').is_not_visible!
  end

  def test_has_text!
    text_field('filled').has_text!('Existing Value')
  end

  def test_does_not_have_text!
    text_field('filled').does_not_have_text!('Wrong Value')
  end

  def test_enter_text_when_blank
    text_field('empty').enter_text('New Value')
    text_field('empty').has_text!('New Value')
  end

  def test_enter_text_when_existing_text
    text_field('filled').enter_text('Updated Value')
    text_field('filled').has_text!('Updated Value')
  end

  def test_clear_text_when_blank
    text_field('empty').clear_text
    text_field('empty').is_blank!
  end

  def test_clear_text_when_existing_text
    text_field('filled').clear_text
    text_field('filled').is_blank!
  end

end
