class HApplication
  
  attr_reader :controller
  
  def initialize(controller)
    @controller = controller
    @controller.start
  end

end