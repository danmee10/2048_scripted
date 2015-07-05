require_relative "strategy"
require 'pry'

class WinningStrat < Strategy

  def run
    tiles = poll_game_board
    elem.send_keys analyze_moves(tiles)
  end

  # get all tiles
  def poll_game_board
    driver.find_elements(:class, 'tile').map do |elem|
      h = {}
      classes = elem.attribute('class').split(" ")
      h[:value] = classes.select{|c| !/tile-\d+/.match(c).nil? }.first.split("-").last.to_i
      pos = classes.select{|c| !/tile-position-\d-\d/.match(c).nil? }.first.split("-")
      h[:position] = [pos[-2].to_i, pos[-1].to_i]
      h
    end
  end

  # check for moves that result in combination
  def analyze_moves(tiles)
    horis = analyze_horis(tiles)
    vert = analyze_vert(tiles)
    if horis > vert
      puts "1 --> #{horis}, #{vert}"
      [:arrow_right, :left].sample
    elsif horis < vert
      puts "2 --> #{horis}, #{vert}"
      [:arrow_down, :arrow_up].sample
    elsif (horis == vert) && (vert != 0)
      puts "3 --> #{horis}, #{vert}"
      [:arrow_down, :arrow_up].sample
    else
      sample = [:arrow_left, :arrow_up, :arrow_right, :arrow_down].sample
      puts "sample --> #{sample}"
      sample
    end
  end

  def analyze_horis(tiles)
    rows = row_buckets(tiles)
    combinations = 0

    rows.each do |c|
      combinations += horis_combinations(c)
    end

    combinations
  end

  def horis_combinations(col)
    col.sort!{|a, b| a[:position][0] <=> b[:position][0]}
    col.chunk{ |t| t[:value] }.select{|c| c[1].length > 1}.count
  end

  def row_buckets(tiles)
    [
      tiles.select{|t| t[:position][1] == 1 },
      tiles.select{|t| t[:position][1] == 2 },
      tiles.select{|t| t[:position][1] == 3 },
      tiles.select{|t| t[:position][1] == 4 }
    ]
  end

  def analyze_vert(tiles)
    cols = column_buckets(tiles)
    combinations = 0

    cols.each do |c|
      combinations += vert_combinations(c)
    end

    combinations
  end

  def vert_combinations(col)
    col.sort!{|a, b| a[:position][1] <=> b[:position][1]}
    col.chunk{ |t| t[:value] }.select{|c| c[1].length > 1}.count
  end

  def column_buckets(tiles)
    [
      tiles.select{|t| t[:position][0] == 1 },
      tiles.select{|t| t[:position][0] == 2 },
      tiles.select{|t| t[:position][0] == 3 },
      tiles.select{|t| t[:position][0] == 4 }
    ]
  end

end
