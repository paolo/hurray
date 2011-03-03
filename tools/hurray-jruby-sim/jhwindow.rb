require 'java'

include_class 'javax.swing.JFrame'

class JHWindow < JFrame
  
  attr_accessor :hwindow
  def initialize(hwindow)
    super "JRuby Simulator"
    @hwindow = hwindow
    setLayout nil
    setSize @hwindow.width, @hwindow.height
    setResizable false
  end
end