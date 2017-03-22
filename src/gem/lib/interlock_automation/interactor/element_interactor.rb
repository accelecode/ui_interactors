require 'selenium-webdriver'
require_relative 'base_interactor'

module InterlockAutomation module Interactor class ElementInteractor < BaseInteractor

  def initialize(driver, name, xpath_root='//*')
    super
  end

  def has_text!(text)
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { find_element.text == text }
  end

  def does_not_have_text!(text)
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { find_element.text != text }
  end

  private

  def current_xpath
    "#{@xpath_root}/*[@data-element='#{@name}']"
  end

end end end
