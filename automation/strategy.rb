class Strategy
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run(elem)
    case name
    when "clockwise" then run_clockwise(elem)
    when "counter_clockwise" then run_counter_clockwise(elem)
    when "random" then run_random(elem)
    else
      raise "Not implemented error"
    end
  end

  def run_clockwise(elem)
    elem.send_keys :arrow_left
    elem.send_keys :arrow_up
    elem.send_keys :arrow_right
    elem.send_keys :arrow_down
  end

  def run_counter_clockwise(elem)
    elem.send_keys :arrow_left
    elem.send_keys :arrow_down
    elem.send_keys :arrow_right
    elem.send_keys :arrow_up
  end

  def run_random(elem)
    arr = [:arrow_left, :arrow_up, :arrow_right, :arrow_down]
    elem.send_keys arr.sample
  end
end