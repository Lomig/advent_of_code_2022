# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/rock_paths_parser"
require_relative "lib/scan"

class Day14 < AoC
  def result1
    Scan.new(rock_paths: RockPathsParser.new.parse(input))
        .avalanche!(mode: :bottomless_pit)
        .sand_capacity
  end

  def result2
    Scan.new(rock_paths: RockPathsParser.new.parse(input))
        .avalanche!
        .sand_capacity + 1
  end
end
