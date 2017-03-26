require 'singleton'
require 'selenium-webdriver'

class DriverProvider
  include Singleton

  attr_reader :driver

  def initialize
    @driver = Selenium::WebDriver.for(:chrome)
  end

end
