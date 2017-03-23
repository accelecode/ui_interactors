module InterlockAutomation module Interactor class ViewInteractor < BaseInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    super
  end

  def view(name)
    ViewInteractor.new(@driver, name, current_xpath)
  end

  def action(name)
    ActionInteractor.new(@driver, name, current_xpath)
  end

  def element(name)
    ElementInteractor.new(@driver, name, current_xpath)
  end

  def list(name)
    ListInteractor.new(@driver, name, current_xpath)
  end

  def text_field(name)
    TextFieldInteractor.new(@driver, name, current_xpath)
  end

  def dropdown_field(name)
    DropdownFieldInteractor.new(@driver, name, current_xpath)
  end

  def checkbox_field(name)
    CheckboxFieldInteractor.new(@driver, name, current_xpath)
  end

  private

  def current_xpath
    (@name ? "#{@xpath_root}//*[@data-view='#{@name}']" : @xpath_root)
  end

end end end
