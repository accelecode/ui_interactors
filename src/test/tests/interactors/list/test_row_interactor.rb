require_relative '../../base_test'

class TestRowInteractor < BaseTest

  def setup
    super
    ui_steps.navigate_to_home
  end

  def test_is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).is_visible!
  end

  def test_is_not_visible!
    list('people').row(texts: {firstName: 'Brian', lastName: 'Miller'}).is_not_visible!
  end

  def test_action_is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).action('view-record').is_visible!
  end

  def test_action_is_not_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).action('action-does-not-exist').is_not_visible!
  end

  def test_activate_action
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).action('view-record').activate
    view('home').is_not_visible!
    view('person').text('name').has_text!('John Miller')
  end

  def test_view_is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).view('friends').is_visible!
  end

  def test_view_is_not_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).view('does-not-exist').is_not_visible!
  end

  def test_element_is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).text('second').is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).view('friends').text('second').is_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).view('friends').text('second').has_text!('Amy')
  end

  def test_element_is_not_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).text('does-not-exist').is_not_visible!
    list('people').row(texts: {firstName: 'John', lastName: 'Miller'}).view('friends').text('does-not-exist').is_not_visible!
  end

end
