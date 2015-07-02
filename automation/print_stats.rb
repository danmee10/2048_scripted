require "CSV"


cs = CSV.read('scores.csv', headers: true).select{|obj| obj["strategy"] == 'clockwise'}
ccs = CSV.read('scores.csv', headers: true).select{|obj| obj["strategy"] == 'counter_clockwise'}
rs = CSV.read('scores.csv', headers: true).select{|obj| obj["strategy"] == 'random'}
ws = CSV.read('scores.csv', headers: true).select{|obj| obj["strategy"] == 'winning'}

cs_average = cs.map{|o| o['score'].to_i}.reduce(:+) / cs.length
ccs_average = ccs.map{|o| o['score'].to_i}.reduce(:+) / ccs.length
rs_average = rs.map{|o| o['score'].to_i}.reduce(:+) / rs.length
ws_average = ws.map{|o| o['score'].to_i}.reduce(:+) / ws.length

cs_max = cs.map{|o| o['score'].to_i}.max
ccs_max = ccs.map{|o| o['score'].to_i}.max
rs_max = rs.map{|o| o['score'].to_i}.max
ws_max = ws.map{|o| o['score'].to_i}.max

cs_min = cs.map{|o| o['score'].to_i}.min
ccs_min = ccs.map{|o| o['score'].to_i}.min
rs_min = rs.map{|o| o['score'].to_i}.min
ws_min = ws.map{|o| o['score'].to_i}.min


puts "avg clockwise_score --> #{cs_average}"
puts "avg counter_clockwise_score --> #{ccs_average}"
puts "avg random_score --> #{rs_average}"
puts "avg winning_score --> #{ws_average}"

puts "\n"
puts "clockwise_max --> #{cs_max}"
puts "counter_clockwise_max --> #{ccs_max}"
puts "random_max --> #{rs_max}"
puts "winning_max --> #{ws_max}"

puts "\n"
puts "clockwise_min --> #{cs_min}"
puts "counter_clockwise_min --> #{ccs_min}"
puts "random_min --> #{rs_min}"
puts "winning_min --> #{ws_min}"