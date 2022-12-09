# frozen_string_literal: true

class Point
  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
    @has_been_visited_by_tail = false
  end

  def visited_by_tail? = @has_been_visited_by_tail

  def visit! = @has_been_visited_by_tail = true
end
