require "hview"

class HWindow
  
  attr_accessor :width, :height, :view
  
  def initialize(width, height)
    @width = width
    @height = height
  end
  
  def addView(view)
    @view = view
  end
  
  def makeVisible
  end
end
