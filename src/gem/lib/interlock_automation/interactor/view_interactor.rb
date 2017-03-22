require_relative 'base_interactor'
require_relative 'action_interactor'
require_relative 'element_interactor'

module InterlockAutomation module Interactor class ViewInteractor < BaseInteractor

  def initialize(driver, name=nil, xpath_root='//*')
    super
  end

  def view(name)
    ViewInteractor.new(@driver, name, current_xpath)
  end

  def action(name)
    ActionInteractor.new(@driver, name, current_xpath)
  end

  def element(name)
    ElementInteractor.new(@driver, name, current_xpath)
  end

  private

  def current_xpath
    (@name ? "#{@xpath_root}/*[@data-view='#{@name}']" : @xpath_root)
  end

end end end
