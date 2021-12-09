# frozen_string_literal: true

# Advent of Code - Day 1
# Count the number of increases in a list of numbers from a text file.
class DayOne
  def initialize(readings)
    @readings = readings
  end

  def part_one
    @readings.each_cons(2).select { |r| r.first < r.last }.length
  end

  def part_two
    @readings.each_cons(3).collect(&:sum).each_cons(2).select { |r| r.first < r.last }.length
  end
end
