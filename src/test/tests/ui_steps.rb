class UiSteps

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def navigate_to_home
    driver.navigate.to('http://localhost:8000/')
  end

end