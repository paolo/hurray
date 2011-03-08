require "happlication"
require "happlication_controller"
require "hwindow"
require "hlabel"
require "hrect"

class HelloWorldController < HApplicationController
  
  def initialize
  end
  
  def start
    @view = HWindow.new HRect.new(0, 0, 320, 480)
    
    label = HLabel.new HRect.new(20, 20, 150, 25)
    label.text = "Hello World"
    
    @view.add_subview label
    @view.make_visible
  end
end

HApplication.new(HelloWorldController.new)