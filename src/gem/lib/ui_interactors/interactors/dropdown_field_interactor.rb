module UiInteractors module Interactors class DropdownFieldInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def option_is_selected!(option_name)
    wait.until { find_element.first_selected_option.text == option_name }
  end

  def option_is_not_selected!(option_name)
    wait.until { find_element.first_selected_option.text != option_name }
  end

  def empty_option_is_selected!
    option_is_selected!('')
  end

  def select_option(option_name)
    find_element.select_by(:text, option_name)
  end
  
  def select_empty_option
    select_option('')
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@name='#{@name}']"
  end

  def find_element
    element = super
    Selenium::WebDriver::Support::Select.new(element)
  end

end end end
