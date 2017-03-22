require_relative '../../base_test'

class TestDropdownFieldInteractorMultiLevel < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    view('home').view('inputs').dropdown_field('selected').is_visible!
  end

  def test_is_not_visible!
    view('home').view('inputs').dropdown_field('dropdown-input-that-does-not-exist').is_not_visible!
  end

  def test_option_is_selected!
    view('home').view('inputs').dropdown_field('selected').option_is_selected!('Second')
  end

  def test_option_is_not_selected!
    view('home').view('inputs').dropdown_field('selected').option_is_not_selected!('First')
  end

  def test_select_option_when_no_option_selected
    view('home').view('inputs').dropdown_field('unselected').select_option('Third')
    view('home').view('inputs').dropdown_field('unselected').option_is_selected!('Third')
  end

  def test_select_option_when_existing_option_selected
    view('home').view('inputs').dropdown_field('selected').select_option('First')
    view('home').view('inputs').dropdown_field('selected').option_is_selected!('First')
  end

  def test_select_empty_option_when_no_option_selected
    view('home').view('inputs').dropdown_field('unselected').select_empty_option
    view('home').view('inputs').dropdown_field('unselected').empty_option_is_selected!
  end

  def test_select_empty_option_when_option_selected
    view('home').view('inputs').dropdown_field('selected').select_empty_option
    view('home').view('inputs').dropdown_field('selected').empty_option_is_selected!
  end

end
