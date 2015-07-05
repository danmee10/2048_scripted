require "selenium-webdriver"
require "CSV"
require_relative "strategies/clockwise_strat"
require_relative "strategies/counter_clockwise_strat"
require_relative "strategies/random_strat"

csv_path = File.expand_path(File.dirname(__FILE__)) + "/scores.csv"

@driver = Selenium::WebDriver.for :firefox
@driver.navigate.to "file://localhost/Users/danielmee/Code/2048_scripted/index.html"

wait = Selenium::WebDriver::Wait.new(:timeout => 30)
time = Time.now
wait.until { Time.now > (time + 5) }

@element = @driver.find_element(:class, 'game-container')


if ARGV.empty?
  strategies = ["clockwise", "counter_clockwise", "random", "winning"]
else
  strategies = ARGV[0].split(" ")
end


@clockwise_scores = []
@counter_clockwise_scores = []
@random_scores = []
@winning_scores = []

def do_clockwise
  while @driver.find_elements(:class, 'game-over').empty?
    ClockwiseStrat.new(@driver).run
  end
  @clockwise_scores << @driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  @driver.find_element(:class, 'retry-button').click
end

def do_counter_clockwise
  while @driver.find_elements(:class, 'game-over').empty?
    CounterClockwiseStrat.new(@driver).run
  end
  @counter_clockwise_scores << @driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  @driver.find_element(:class, 'retry-button').click
end

def do_random
  while @driver.find_elements(:class, 'game-over').empty?
    RandomStrat.new(@driver).run
  end
  @random_scores << @driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  @driver.find_element(:class, 'retry-button').click
end

def do_winning
  while @driver.find_elements(:class, 'game-over').empty?
    WinningStrat.new(@driver).run
  end
  @winning_scores << @driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  @driver.find_element(:class, 'retry-button').click
end

2.times do
  do_clockwise if strategies.include? "clockwise"

  do_counter_clockwise if strategies.include? "counter_clockwise"

  do_random if strategies.include? "random"

  do_winning if strategies.include? "winning"
end


CSV.open(csv_path, "ab") do |csv|
  date = Date.today.strftime('%m/%d/%Y')
  @clockwise_scores.each do |cs|
    csv << ["clockwise", cs, date]
  end
  @counter_clockwise_scores.each do |ccs|
    csv << ["counter_clockwise", ccs, date]
  end
  @random_scores.each do |rs|
    csv << ["random", rs, date]
  end
  @winning_scores.each do |rs|
    csv << ["winning", rs, date]
  end
end

@driver.quit