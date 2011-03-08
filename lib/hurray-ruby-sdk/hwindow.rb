require "yaml"
require "hview"

class HWindow < HView

  def initialize(rect)
    super rect
  end
  
  def make_visible
    puts YAML::dump self
  end

end
