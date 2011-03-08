class HRect
  
  attr_accessor :x, :y, :width, :height
  
  def initialize(x, y, w, h)
    @x = x
    @y = y
    @width = w
    @height = h
  end
  
  def self.create(options = {:x => 0, :y => 0, :width => 0, :height => 0})
    HRect.new(options[:x], options[:y], options[:width], options[:height])
  end
  
end