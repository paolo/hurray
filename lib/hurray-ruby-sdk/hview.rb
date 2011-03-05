require "yaml"

class HView
  
  attr_accessor :frame
  attr_reader :subviews
  
  def initialize(rect)
    @frame = rect
    @subviews = []
  end
  
  def add_subview(view)
    @subviews.push view
  end
  
  def make_visible
    puts YAML::dump self
  end
end