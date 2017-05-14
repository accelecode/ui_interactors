module UiInteractors module Interactors class ListInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def row(selector_options)
    RowInteractor.new(@driver, selector_options, current_xpath)
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@data-view='#{@name}']"
  end

end end end
