#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_MAP = {
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
}

def input
  @input ||= DATA.read.split("\n")
end

def part1
  input.sum do |line|
    digits = line.scan(/\d/)

    (digits.first + digits.last).to_i
  end
end

def part2
  input.sum do |line|
    map = {}

    NUMBER_MAP.each do |int, str|
      # First int match
      int_match = line.index(int.to_s)
      map[int_match] = int if int_match

      # Second int match
      int_match = line.rindex(int.to_s)
      map[int_match] = int if int_match

      # First str match
      str_match = line.index(str)
      map[str_match] = NUMBER_MAP.key(str) if str_match

      # Second str match
      str_match = line.rindex(str)
      map[str_match] = NUMBER_MAP.key(str) if str_match
    end

    map.minmax.map(&:last).join.to_i
  end
end

puts "part1: #{part1}"
puts "part2: #{part2}"

__END__
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
