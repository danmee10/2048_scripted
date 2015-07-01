require "selenium-webdriver"
require "CSV"
require_relative "strategy"

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://gabrielecirulli.github.io/2048/"

wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
time = Time.now

wait.until { Time.now > (time + 5) }

element = driver.find_element(:class, 'game-container')


clockwise_scores = []
counter_clockwise_scores = []
random_scores = []


10.times do
  while driver.find_elements(:class, 'game-over').empty?
    Strategy.new("clockwise").run(element)
  end
  clockwise_scores << driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  driver.find_element(:class, 'retry-button').click

  while driver.find_elements(:class, 'game-over').empty?
    Strategy.new("counter_clockwise").run(element)
  end
  counter_clockwise_scores << driver.find_element(:class, 'score-container').text.split(/\D/)[0]

  driver.find_element(:class, 'retry-button').click

  while driver.find_elements(:class, 'game-over').empty?
    Strategy.new("random").run(element)
  end
  random_scores << driver.find_element(:class, 'score-container').text.split(/\D/)[0]
end






CSV.open("automation/scores.csv", "ab") do |csv|
  date = Date.today.strftime('%m/%d/%Y')
  clockwise_scores.each do |cs|
    csv << ["clockwise", cs, date]
  end
  counter_clockwise_scores.each do |ccs|
    csv << ["counter_clockwise", ccs, date]
  end
  random_scores.each do |rs|
    csv << ["random", rs, date]
  end
end


cs = CSV.read('automation/scores.csv', headers: true).select{|obj| obj["strategy"] == 'clockwise'}
ccs = CSV.read('automation/scores.csv', headers: true).select{|obj| obj["strategy"] == 'counter_clockwise'}
rs = CSV.read('automation/scores.csv', headers: true).select{|obj| obj["strategy"] == 'random'}

cs_average = cs.map{|o| o['score'].to_i}.reduce(:+) / cs.length
ccs_average = ccs.map{|o| o['score'].to_i}.reduce(:+) / ccs.length
rs_average = rs.map{|o| o['score'].to_i}.reduce(:+) / rs.length


puts "avg clockwise_score --> #{cs_average}"
puts "avg counter_clockwise_score --> #{ccs_average}"
puts "avg random_score --> #{rs_average}"

driver.quit