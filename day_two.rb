# frozen_string_literal: true

# Advent of Code - Day 2
# Navigate horizontally and with a depth.
class DayTwo
  def initialize(readings)
    @readings = readings
    @depth = 0
    @position = 0
    @aim = 0
  end

  def part_one
    @readings.each do |reading|
      (direction, distance) = reading.split
      move(direction.to_sym, distance.to_i)
    end
    @depth * @position
  end

  def part_two
    @readings.each do |reading|
      (direction, distance) = reading.split
      move_or_aim(direction.to_sym, distance.to_i)
    end
    @depth * @position
  end

  private

  def move(direction, distance)
    case direction
    when :down
      @depth += distance
    when :forward
      @position += distance
    when :up
      @depth -= distance
    end
  end

  def move_or_aim(direction, distance)
    case direction
    when :down
      @aim += distance
    when :forward
      @position += distance
      @depth += (distance * @aim)
    when :up
      @aim -= distance
    end
  end
end
