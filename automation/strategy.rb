class Strategy
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run(element)
    case name
    when "clockwise" then run_clockwise(element)
    when "counter_clockwise" then run_counter_clockwise(element)
    when "random" then run_random(element)
    else
      raise "Not implemented error"
    end
  end

  def run_clockwise(element)
    element.send_keys :arrow_left
    element.send_keys :arrow_up
    element.send_keys :arrow_right
    element.send_keys :arrow_down
  end

  def run_counter_clockwise(element)
    element.send_keys :arrow_left
    element.send_keys :arrow_down
    element.send_keys :arrow_right
    element.send_keys :arrow_up
  end

  def run_random(element)
    arr = [:arrow_left, :arrow_up, :arrow_right, :arrow_down]
    element.send_keys arr.sample
  end
end