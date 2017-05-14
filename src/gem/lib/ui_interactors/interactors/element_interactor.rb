module UiInteractors module Interactors class ElementInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def has_text!(text)
    wait.until { find_element.text == text }
  end

  def does_not_have_text!(text)
    wait.until { find_element.text != text }
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@data-element='#{@name}']"
  end

end end end
