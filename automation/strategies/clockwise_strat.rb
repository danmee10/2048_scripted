require_relative "strategy"

class ClockwiseStrat < Strategy

  def run
    elem.send_keys :arrow_left
    elem.send_keys :arrow_up
    elem.send_keys :arrow_right
    elem.send_keys :arrow_down
  end

end