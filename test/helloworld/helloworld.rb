require "happlication"
require "hwindow"
require "hview"

class HMain
  attr_reader :appDelegate
  
  def initialize
    @appDelegate = HelloWorldDelegate.new
  end
  
  def main
    HApplication.application_main(@appDelegate)
  end
  
end

class HelloWorldDelegate
  attr_accessor :window
  
  def initialize
    @window = HWindow.new(480,640)
  end
  
  def init
    view = HView.new
    @window.addView view
    @window.makeVisible
  end
end
