require "happlication"
require "jhwindow"
require "helloworld"

class Simulator
  def initialize(app)
    HApplication.new(app)
    @jhwindow = JHWindow.new(app.view)
    
    @jhwindow.setVisible true
  end
end

application_main = ARGV.first
if !application_main.nil?
  begin
    app = Object::const_get(application_main).new
    if (app.kind_of? HApplicationController)
      Simulator.new(app)
    else
      puts "Class should include the HApplicationMain module"
    end
  rescue NameError
    puts "Invalid class name"
    exit 1
  end
else
  puts "Invalid argument"
end