# frozen_string_literal: true

class Node
  attr_reader :name
  attr_accessor :distance_from_start, :neighbours

  def initialize(name:)
    @name = name
    @neighbours = []

    reset!
  end

  def reset!
    @has_been_visited = false
    self.distance_from_start = Float::INFINITY
  end

  def visited? = @has_been_visited

  def visit!
    @has_been_visited = true
  end

  def accessible_from?(other) = height <= other.height + 1

  def height
    return 1 if name == ?S
    return 26 if name == ?E

    name.ord - "a".ord + 1
  end
end
