require_relative "strategy"

class CounterClockwiseStrat < Strategy

  def run
    elem.send_keys :arrow_left
    elem.send_keys :arrow_down
    elem.send_keys :arrow_right
    elem.send_keys :arrow_up
  end

end