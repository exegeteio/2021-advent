# frozen_string_literal: true

require 'matrix'

# Advent of Code - Day 4
# Playing bingo with a giant squid.
class DayFour
  # Constant matrix size for bingo boards, 5x5.
  MATRIX_SIZE = 5

  def initialize(input)
    # Pull off the first line and split into integers.
    @draws = input.shift.strip.split(/\D/).map(&:to_i)
    @boards = []
    # Remove blanks from input and build out Boards.
    build_boards process_input(input.reject(&:empty?))
  end

  def part_one
    # Draw numbers one-by-one...
    @draws.each do |drawn|
      # Look at each of our boards...
      @boards.each do |board|
        # Mark if the board matches the number.
        board.mark! drawn
        # Bail out if we have a winner.
        return board.score if board.winner?
      end
    end
  end

  def part_two
    # Store whichever board won last so the squid doesn't eat us!
    last_winner = nil
    # Draw numbers one-by-one...
    @draws.each do |drawn|
      # Look at each of our boards...
      @boards.select do |board|
        # Mark if the board matches the number.
        board.mark! drawn
        # Overwrite any previous winners if we just won.
        last_winner = board if board.winner?
      end
      # Remove winners for the next iteration of drawn.
      @boards.delete_if(&:winner?)
    end
    # Return the score of the last winner.
    last_winner.score
  end

  private

  # Convert input lines into integers, and split by the MATRIX_SIZE variable.
  def process_input(input)
    input.map { |line| line.split(/\s+/).map(&:to_i) }.each_slice(MATRIX_SIZE)
  end

  # Loop over input rows and create boards.
  def build_boards(inputs)
    inputs.each { |rows| @boards << Board[*rows] }
  end

  # Represent the bingo board as a matrix.
  class Board < Matrix
    # Store a list of marked inputs.
    def mark!(input)
      @marked ||= []
      @marked << input
    end

    # If any rows or columns are empty after removing marked entires, we have a winner.
    def winner?
      rows.any? { |row| (row - @marked).empty? } || columns.any? { |col| (col - @marked).empty? }
    end

    # Use the last marked times the sum of all not-marked numbers.
    def score
      @marked.last * (rows.flatten - @marked).sum
    end

    private

    # Shortcut to get columns
    def columns
      rows.transpose
    end
  end
end
