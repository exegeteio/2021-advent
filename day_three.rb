# frozen_string_literal: true

# Advent of Code - Day 3
# Binary Diagnostic
class DayThree
  def initialize(readings)
    @readings = readings
    @bits = bits(@readings)
  end

  def part_one
    common_bits.to_i(2) * uncommon_bits.to_i(2)
  end

  def part_two
    common_reduce.to_i(2) * uncommon_reduce.to_i(2)
  end

  private

  def bits(readings = @readings)
    bits = Array.new(readings.first.length) { [] }
    readings.each do |reading|
      reading.split('').each_with_index do |bit, index|
        bits[index] << bit.to_i
      end
    end
    bits
  end

  def common_bits
    bits.collect do |bit_array|
      bit_array.max_by do |bit|
        bit_array.count(bit)
      end
    end.join('')
  end

  def uncommon_bits
    bits.collect do |bit_array|
      bit_array.min_by do |bit|
        bit_array.count(bit)
      end
    end.join('')
  end

  def readings_where_bit_at!(readings, position, value)
    readings.select! { |bit_array| bit_array[position] == value.to_s }
  end

  def common_reduce(readings = @readings.clone, position = 0)
    return readings.first if readings.length <= 1

    bit_arrays = bits(readings)
    case bit_arrays[position].count(0) <=> bit_arrays[position].count(1)
    when -1 # One is more common
      readings_where_bit_at!(readings, position, 1)
    when 1 # Zero is more common
      readings_where_bit_at!(readings, position, 0)
    when 0 # Equal commonality
      readings_where_bit_at!(readings, position, 1)
    end
    common_reduce(readings, position + 1)
  end

  def uncommon_reduce(readings = @readings, position = 0)
    return readings.first if readings.length <= 1

    bit_arrays = bits(readings)
    case bit_arrays[position].count(1) <=> bit_arrays[position].count(0)
    when -1 # Zero is more common
      readings_where_bit_at!(readings, position, 1)
    when 1 # One is more common
      readings_where_bit_at!(readings, position, 0)
    when 0 # Equal commonality
      readings_where_bit_at!(readings, position, 0)
    end
    uncommon_reduce(readings, position + 1)
  end
end
