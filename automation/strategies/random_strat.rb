require_relative "strategy"

class RandomStrat < Strategy

  def run
    arr = [:arrow_left, :arrow_up, :arrow_right, :arrow_down]
    elem.send_keys arr.sample
  end

end