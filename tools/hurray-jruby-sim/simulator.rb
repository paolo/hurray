require "jhwindow"
require "helloworld"

class Simulator
  def initialize
    @hmain = HMain.new
    @jhwindow = JHWindow.new(@hmain.appDelegate.window)
    @hmain.main
    @jhwindow.setVisible true
  end
end

Simulator.new