require "hlabel"
require "hview"

class HLabel < HView
  attr_accessor :text
  
  def initialize(rect)
    super rect
  end
end