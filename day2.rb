#!/usr/bin/env ruby

require "pry-byebug"

def input
  @input ||= DATA.read.split("\n")
end

class GameSubset
  attr_accessor(:red, :green, :blue)

  def initialize(red: 0, green: 0, blue: 0)
    @red = red
    @green = green
    @blue = blue
  end

  def valid?
    return false if red > 12
    return false if green > 13
    return false if blue > 14

    true
  end
end

class Game
  attr_reader(:id, :subsets)

  def initialize(id:, subsets:)
    @id = id
    @subsets = subsets
  end
end

def parse_games
  games = []

  input.each do |line|
    first_part, last_part = line.split(": ")

    game_id = first_part.match(/\d+/)[0].to_i

    game = Game.new(id: game_id, subsets: [])

    last_part.split("; ").each do |subset|
      matches = subset.scan(/(?<count>\d+)\s+(?<color>red|green|blue)/)

      game_subset = GameSubset.new

      matches.each do |(num, color)|
        game_subset.send("#{color}=", num.to_i)
      end

      game.subsets << game_subset
    end

    games << game
  end

  games
end

def part1
  games = parse_games

  games.sum do |game|
    if game.subsets.all?(&:valid?)
      game.id
    else
      0
    end
  end
end

puts "part1: #{part1}"

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
