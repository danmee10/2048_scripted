class Strategy
  attr_reader :driver, :elem

  def initialize(driver)
    @driver = driver
    @elem = @driver.find_element(:class, 'game-container')
  end

  def run
    raise "Not implemented error"
  end

end