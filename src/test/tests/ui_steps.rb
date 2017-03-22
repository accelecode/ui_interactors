class UiSteps

  attr_reader :driver, :root_view

  def initialize(driver, root_view)
    @driver = driver
    @root_view = root_view
  end

  def navigate_to_home
    driver.navigate.to('http://localhost:8000/')
  end

end
