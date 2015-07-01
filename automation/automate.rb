require "selenium-webdriver"
require "CSV"
require_relative "strategy"

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://gabrielecirulli.github.io/2048/"

wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
time = Time.now

wait.until { Time.now > (time + 5) }

element = driver.find_element(:class, 'game-container')


while driver.find_elements(:class, 'game-over').empty?
  Strategy.new("clockwise").run(element)
end
clockwise_score = driver.find_element(:class, 'score-container').text.split(/\D/)[0]

driver.find_element(:class, 'retry-button').click

while driver.find_elements(:class, 'game-over').empty?
  Strategy.new("counter_clockwise").run(element)
end
counter_clockwise_score = driver.find_element(:class, 'score-container').text.split(/\D/)[0]

driver.find_element(:class, 'retry-button').click

while driver.find_elements(:class, 'game-over').empty?
  Strategy.new("random").run(element)
end
random_score = driver.find_element(:class, 'score-container').text.split(/\D/)[0]






CSV.open("automation/scores.csv", "ab") do |csv|
  csv << ["clockwise", clockwise_score]
  csv << ["counter_clockwise", counter_clockwise_score]
  csv << ["random", random_score]
end

puts "clockwise_score --> #{clockwise_score}"
puts "counter_clockwise_score --> #{counter_clockwise_score}"
puts "random_score --> #{random_score}"

driver.quit