# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/map_creator"
require_relative "lib/node"

class Day12 < AoC
  input_as :matrix, formatter: ->(element, _, _) { Node.new(name: element) }

  def result1
    MapCreator.new(input:).create_map!
              .shortest_path_from_starting_points
  end

  def result2
    MapCreator.new(input:, starting_location: "a").create_map!
              .shortest_path_from_starting_points
  end
end
