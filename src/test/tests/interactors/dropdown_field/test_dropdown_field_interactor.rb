require_relative '../../base_test'

class TestDropdownFieldInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    dropdown_field('selected').is_visible!
  end

  def test_is_not_visible!
    dropdown_field('dropdown-input-that-does-not-exist').is_not_visible!
  end

  def test_option_is_selected!
    dropdown_field('selected').option_is_selected!('Second')
  end

  def test_option_is_not_selected!
    dropdown_field('selected').option_is_not_selected!('First')
  end

  def test_select_option_when_no_option_selected
    dropdown_field('unselected').select_option('Third')
    dropdown_field('unselected').option_is_selected!('Third')
  end

  def test_select_option_when_existing_option_selected
    dropdown_field('selected').select_option('First')
    dropdown_field('selected').option_is_selected!('First')
  end

  def test_select_empty_option_when_no_option_selected
    dropdown_field('unselected').select_empty_option
    dropdown_field('unselected').empty_option_is_selected!
  end

  def test_select_empty_option_when_option_selected
    dropdown_field('selected').select_empty_option
    dropdown_field('selected').empty_option_is_selected!
  end

end
