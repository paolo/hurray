require 'java'

include_class 'javax.swing.JLabel'

class JHLabel < JLabel
  attr_accessor :hlabel
  
  def initialize(hlabel)
    super hlabel.text
    @hlabel = hlabel
    setBounds @hlabel.frame.x, @hlabel.frame.y, @hlabel.frame.width, @hlabel.frame.height
  end
end