# frozen_string_literal: true

require_relative "point"

class Grid
  VECTORS = {
    up:    [ 0,  1],
    right: [ 1,  0],
    down:  [ 0, -1],
    left:  [-1,  0]
  }.freeze

  attr_reader :starting_point

  private attr_reader :points

  def initialize
    @starting_point = Point.new(x: 0, y: 0)
    @points = {[0, 0] => @starting_point}
  end

  def visited_points = @points.values.select(&:visited_by_tail?)

  def point_from(point:, direction:) = find_or_create_translated_point(point, VECTORS[direction])

  def point_towards(point:, target:)
    return point if (point.x - target.x).abs <= 1 && (point.y - target.y).abs <= 1

    find_or_create_translated_point(point, approaching_vector(point:, target:))
  end

  private

  def find_or_create_translated_point(point, vector)
    x = point.x + vector.first
    y = point.y + vector.last

    return points[[x, y]] || points[[x, y]] = Point.new(x:, y:)
  end

  def approaching_vector(point:, target:)
    [
      target.x - point.x,
      target.y - point.y
    ].map { |num| num.zero? ? 0 : num / num.abs }
  end
end
