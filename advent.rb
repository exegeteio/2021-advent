#!/usr/bin/env ruby
# frozen_string_literal: true

require './day_one'
require './day_two'
require './day_three'

day_one = DayOne.new(
  File.readlines('day_one_data.txt').map(&:to_i)
)
puts "Day One Part One:  #{day_one.part_one}"
puts "Day One Part Two:  #{day_one.part_two}"

day_two = DayTwo.new(
  File.readlines('day_two_data.txt')
)
puts "Day Two Part One:  #{day_two.part_one}"
puts "Day Two Part Two:  #{day_two.part_two}"

