require 'java'
require "jhlabel"

include_class 'javax.swing.JFrame'

class JHWindow < JFrame
  
  attr_accessor :hwindow
  def initialize(hwindow)
    super "JRuby Simulator"
    @hwindow = hwindow
    setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
    setLayout nil
    setSize @hwindow.frame.width, @hwindow.frame.height
    setResizable false
    
    @hwindow.subviews.each do |subview|
      case subview.class.to_s
        when "HLabel" then self.add(JHLabel.new(subview))
      end
    end

  end
end