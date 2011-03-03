class HApplication
  class << self
    def application_main(appDelegate)
      @appDelegate = appDelegate
      @appDelegate.init
    end
  end
end