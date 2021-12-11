# frozen_string_literal: true

# Advent of Code - Day 1
# Count the number of increases in a list of numbers from a text file.
class DayOne
  def initialize(readings)
    # Turn the readings into Integers.
    @readings = readings.map(&:to_i)
  end

  def part_one
    # Group into arrays with 2 entries, and find how many have lower first values than second.
    @readings.each_cons(2).select { |r| r.first < r.last }.length
  end

  def part_two
    # Sum up each consecutive 3 entries, then group into arrays with 2 entries, and find how many
    # have lower first values than second.
    @readings.each_cons(3).collect(&:sum).each_cons(2).select { |r| r.first < r.last }.length
  end
end
