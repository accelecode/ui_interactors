require_relative '../../base_test'

class TestCheckboxFieldInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').view('inputs').checkbox_field('checked').is_visible!
  end

  def test_is_not_visible!
    view('home').view('inputs').checkbox_field('checkbox-that-does-not-exist').is_not_visible!
  end

  def test_is_checked!
    view('home').view('inputs').checkbox_field('checked').is_checked!
  end

  def test_is_not_checked!
    view('home').view('inputs').checkbox_field('unchecked').is_not_checked!
  end

  def test_check_when_not_already_checked
    view('home').view('inputs').checkbox_field('unchecked').check
    view('home').view('inputs').checkbox_field('unchecked').is_checked!
  end

  def test_check_when_already_checked
    view('home').view('inputs').checkbox_field('checked').check
    view('home').view('inputs').checkbox_field('checked').is_checked!
  end

  def test_uncheck_when_not_already_checked
    view('home').view('inputs').checkbox_field('unchecked').uncheck
    view('home').view('inputs').checkbox_field('unchecked').is_not_checked!
  end

  def test_uncheck_when_already_checked
    view('home').view('inputs').checkbox_field('checked').uncheck
    view('home').view('inputs').checkbox_field('checked').is_not_checked!
  end

end
