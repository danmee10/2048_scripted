require_relative "strategy"

class WinningStrategy < Strategy

  def run
    driver.find_elements(:class, 'tile')

    # elem.send_keys :arrow_left
    # elem.send_keys :arrow_up
    # elem.send_keys :arrow_right
    # elem.send_keys :arrow_down
    puts "elem.inspect"
  end

end