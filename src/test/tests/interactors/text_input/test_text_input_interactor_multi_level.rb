require_relative '../../base_test'

class TestTextInputInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').view('inputs').text_field('filled').is_visible!
  end

  def test_is_not_visible!
    view('home').view('inputs').text_field('text-input-that-does-not-exist').is_not_visible!
  end

  def test_has_text!
    view('home').view('inputs').text_field('filled').has_text!('Existing Value')
  end

  def test_does_not_have_text!
    view('home').view('inputs').text_field('filled').does_not_have_text!('Wrong Value')
  end

  def test_enter_text_when_blank
    view('home').view('inputs').text_field('empty').enter_text('New Value')
    view('home').view('inputs').text_field('empty').has_text!('New Value')
  end

  def test_enter_text_when_existing_text
    view('home').view('inputs').text_field('filled').enter_text('Updated Value')
    view('home').view('inputs').text_field('filled').has_text!('Updated Value')
  end

  def test_clear_text_when_blank
    view('home').view('inputs').text_field('empty').clear_text
    view('home').view('inputs').text_field('empty').is_blank!
  end

  def test_clear_text_when_existing_text
    view('home').view('inputs').text_field('filled').clear_text
    view('home').view('inputs').text_field('filled').is_blank!
  end

end
