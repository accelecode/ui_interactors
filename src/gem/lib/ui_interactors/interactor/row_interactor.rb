module UiInteractors module Interactor class RowInteractor < ViewInteractor

  def initialize(driver, selector_options, xpath_root='//*')
    super(driver, nil, xpath_root)
    @selector_options = selector_options
  end

  private

  def current_xpath
    elements = @selector_options.fetch(:elements)
    # row selector looks like this:
    # "//*[@data-element='firstName' and normalize-space(text())='John']//ancestor::*[@data-view='row']//*[@data-element='lastName' and normalize-space(text())='Miller']//ancestor::*[@data-view='row']"
    # The generated xpath traverses down into the row and then back up to the row element itself
    row_selector = elements.map { |key, value| "//*[@data-element='#{key}' and normalize-space(text())='#{value}']//ancestor::*[@data-view='row']" }.join
    "#{@xpath_root}//*[@data-view='row']#{row_selector}"
  end

end end end
