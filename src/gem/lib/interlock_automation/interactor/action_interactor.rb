module InterlockAutomation module Interactor class ActionInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def activate
    find_element.click
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@data-action='#{@name}']"
  end

end end end
