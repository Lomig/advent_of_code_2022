# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/move"

class Day2 < AoC
  def result1 = input.sum { |move| Move.complete_move(log: move).score }

  def result2 = input.sum { |move| Move.from_known_score(log: move).score }
end
