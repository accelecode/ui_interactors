module UiInteractors module Interactor class CheckboxFieldInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def is_checked!
    wait.until { find_element.selected? }
  end

  def is_not_checked!
    wait.until { find_element.selected? == false }
  end

  def check
    find_element.tap do |element|
      element.click unless element.selected?
    end
  end

  def uncheck
    find_element.tap do |element|
      element.click if element.selected?
    end
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@name='#{@name}']"
  end

end end end
