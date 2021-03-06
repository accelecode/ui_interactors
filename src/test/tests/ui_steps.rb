require 'forwardable'

class UiSteps
  extend Forwardable

  attr_reader :driver, :root_view

  def_delegators :root_view, :view, :action, :text, :list, :text_field, :dropdown_field, :checkbox_field

  def initialize(driver, root_view)
    @driver = driver
    @root_view = root_view
  end

  def navigate_to_reset
    driver.navigate.to('http://localhost:8000/reset.html')
    view('reset').is_visible!
  end

  def navigate_to_home
    driver.navigate.to('http://localhost:8000/')
    view('home').is_visible!
  end

end
