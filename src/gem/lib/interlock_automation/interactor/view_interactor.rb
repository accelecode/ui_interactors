require 'selenium-webdriver'

module InterlockAutomation module Interactor class ViewInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    @driver = driver
    @name = name
    @xpath_root = xpath_root
  end

  def view(name)
    ViewInteractor.new(@driver, name, current_xpath)
  end

  def is_visible!
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { @driver.find_elements(xpath: current_xpath).count == 1 }
  rescue => e
    raise("xpath is not visible: #{current_xpath}")
  end

  def is_not_visible!
    wait = Selenium::WebDriver::Wait.new(timeout: 5, interval: 0.2)
    wait.until { @driver.find_elements(xpath: current_xpath).count == 0 }
  rescue => e
    raise("xpath is visible: #{current_xpath}")
  end

  private

  def current_xpath
    (@name ? "#{@xpath_root}/*[@data-view='#{@name}']" : @xpath_root)
  end

end end end
