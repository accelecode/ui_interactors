module InterlockAutomation module Interactor class BaseInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    @driver = driver
    @name = name
    @xpath_root = xpath_root
  end

  def is_visible!
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { @driver.find_elements(xpath: current_xpath).count == 1 }
  rescue
    raise("xpath is not visible: #{current_xpath}")
  end

  def is_not_visible!
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { @driver.find_elements(xpath: current_xpath).count == 0 }
  rescue
    raise("xpath is visible: #{current_xpath}")
  end

  private

  def current_xpath
    raise('Subclass must override method')
  end

  def find_element
    is_visible!

    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { @driver.find_element(xpath: current_xpath) }
  end

end end end
