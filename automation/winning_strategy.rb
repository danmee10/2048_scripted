class WinningStrategy
  attr_reader :elem

  def initialize(elem)
    @elem = elem
  end

  def run
    elem.send_keys :arrow_left
    elem.send_keys :arrow_up
    elem.send_keys :arrow_right
    elem.send_keys :arrow_down
  end

end