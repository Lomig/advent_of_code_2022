# frozen_string_literal: true

require_relative "map"

class MapCreator
  OFFSETS = {
    north: [-1,  0],
    east:  [ 0,  1],
    south: [ 1,  0],
    west:  [ 0, -1]
  }

  private attr_reader :matrix, :starting_location, :starting_points
  private attr_accessor :ending_point

  def initialize(input:, starting_location: nil)
    @matrix = input
    @starting_location = starting_location
    @starting_points = []
  end

  def create_map!
    matrix.each_with_index do |node, row, column|
      starting_points << node if node.name == (starting_location || ?S)
      self.ending_point = node if node.name == ?E

      OFFSETS.keys.each { |direction| add_edge(direction:, node:, row:, column:) }
    end

    Map.new(matrix:, starting_points:, ending_point:)
  end

  private

  def add_edge(direction:, node:, row:, column:)
    other_row = row + OFFSETS[direction].first
    other_column = column + OFFSETS[direction].last

    return if out_of_bound?(row: other_row, column: other_column)

    other_node = matrix[other_row, other_column]
    node.neighbours << other_node if other_node.accessible_from?(node)
  end

  def out_of_bound?(row:, column:)
    row < 0 ||
    column < 0 ||
    row == matrix.row_count ||
    column == matrix.column_count
  end
end