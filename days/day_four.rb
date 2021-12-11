# frozen_string_literal: true
#
require 'matrix'

# Advent of Code - Day 4
# Playing bingo with a giant squid.
class DayFour
  # Constant matrix size for bingo boards, 5x5.
  MATRIX_SIZE = 5

  def initialize(input)
    @draws = input.shift.strip.split(/\D/).map(&:to_i)
    @boards = []
    board_lines = []
    input.select(&:present?).map{|line| line.split(/\s+/).map(&:to_i)}.each_slice(MATRIX_SIZE) do |rows|
      @boards << Board[*rows]
    end
  end

  def part_one
    @draws.each do |drawn|
      @boards.each do |board|
        board.draw! drawn
        return board.score(drawn) if board.winner?
      end
    end
  end

  def part_two
    last_drawn = nil
    last_winner = nil
    @draws.each do |drawn|
      @boards.select do |board|
        board.draw! drawn
        if board.winner?
          last_drawn = drawn
          last_winner = board
        end
      end
      @boards.delete_if(&:winner?)
    end
    last_winner.score(last_drawn)
  end

  class Board < Matrix
    def columns
      rows.transpose
    end

    def draw!(needle)
      @drawn ||= []
      @drawn << needle
    end

    def winner?
      rows.any? { |row| (row - @drawn).empty? } || columns.any? { |row| (row - @drawn).empty? }
    end

    def score(needle)
      needle * (rows.flatten - @drawn).sum
    end
  end
end
