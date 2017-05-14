module UiInteractors module Interactors class TextFieldInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def has_text!(text)
    wait.until { find_element.attribute('value') == text }
  end

  def does_not_have_text!(text)
    wait.until { find_element.attribute('value') != text }
  end

  def is_blank!
    has_text!('')
  end

  def enter_text(text)
    find_element.tap do |element|
      element.clear
      element.send_keys(text)
    end
  end

  def clear_text
    find_element.send_keys([:control, 'a'], :delete)
  end

  private

  def current_xpath
    "#{@xpath_root}//*[@name='#{@name}']"
  end

end end end
