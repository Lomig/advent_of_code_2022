# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/crate_parser"
require_relative "lib/move_parser"
require_relative "lib/docks"

class Day5 < AoC
  def result1 = move_crates_with ->(docks, move) { docks.move(**move) }

  def result2 = move_crates_with ->(docks, move) { docks.power_move(**move) }

  private

  def move_crates_with(crane)
    crates_input, moves_input = slice_input_into_crates_and_moves

    crates = CrateParser.new.parse(crates_input)
    docks = Docks.new(crates)

    moves = MoveParser.new.parse(moves_input)
    moves.each { |move| crane.call(docks, move) }

    docks.top_crates
  end

  def slice_input_into_crates_and_moves
    input.slice_when { |cut, _| cut.empty? }
         .to_a
         .tap { |slices| slices.first.pop(2) }
  end
end
