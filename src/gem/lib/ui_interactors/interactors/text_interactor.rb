module UiInteractors module Interactors class TextInteractor < BaseInteractor

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
    "#{@xpath_root}//*[@data-text='#{@name}']"
  end

end end end
