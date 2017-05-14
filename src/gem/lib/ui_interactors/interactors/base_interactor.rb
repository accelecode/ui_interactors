require 'selenium-webdriver'

module UiInteractors module Interactors class BaseInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    @driver = driver
    @name = name
    @xpath_root = xpath_root
  end

  def is_visible!
    wait.until { @driver.find_element(xpath: current_xpath).displayed? }
  rescue
    raise("xpath is not visible: #{current_xpath}")
  end

  def is_not_visible!
    wait.until do
      elements = @driver.find_elements(xpath: current_xpath)
      elements.count == 0 || elements.map(&:displayed?).none?
    end
  rescue
    raise("xpath is visible: #{current_xpath}")
  end

  private

  def current_xpath
    raise('Subclass must override method')
  end

  def wait
    ignored_errors = [
      Selenium::WebDriver::Error::NoSuchElementError,
      Selenium::WebDriver::Error::StaleElementReferenceError
    ]
    Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2, ignore: ignored_errors)
  end

  def find_element
    is_visible!

    wait.until { @driver.find_element(xpath: current_xpath) }
  end

end end end
