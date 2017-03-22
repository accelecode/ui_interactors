require 'selenium-webdriver'
require_relative 'base_interactor'

module InterlockAutomation module Interactor class ViewInteractor < BaseInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    super
  end

  def view(name)
    ViewInteractor.new(@driver, name, current_xpath)
  end

  private

  def current_xpath
    (@name ? "#{@xpath_root}/*[@data-view='#{@name}']" : @xpath_root)
  end

end end end
