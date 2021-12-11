# frozen_string_literal: true

# Advent of Code - Day 4
# Playing bingo with a giant squid.
class DayFour
  def initialize(input)
    @draws = input.shift.strip.split(/\D/).map(&:to_i)
    @boards = []
    input.each do |line|
      if line.blank?
        @boards << Board.new
        next
      end
      @boards.last << line.strip.split(/\s+/).map(&:to_i)
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

  class Board
    def initialize
      @values = []
      @columns = 5
      @rows = 5
      @marked = {
        columns: Array.new(5, 0),
        rows: Array.new(5, 0),
        sum: 0
      }
    end

    def <<(row)
      @values += row
    end

    def draw!(needle)
      loc = @values.index(needle)
      if loc.present?
        column = loc % @rows
        row = (loc - column) / @rows
        @marked[:columns][column] += 1
        @marked[:rows][row] += 1
        @marked[:sum] += needle
      end
      loc.present?
    end

    def score(last_draw)
      (@values.sum - @marked[:sum]) * last_draw
    end

    def winner?
      column_winner? || row_winner?
    end

    def column_winner?
      @marked[:columns].max == @columns
    end

    def row_winner?
      @marked[:rows].max == @rows
    end
  end
end
