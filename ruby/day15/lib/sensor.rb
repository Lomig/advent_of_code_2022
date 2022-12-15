# frozen_string_literal: true

class Sensor
  attr_reader :x, :y

  private attr_reader :beacon_x, :beacon_y, :range, :vertical_range, :horizontal_range

  def initialize(sensor_x:, sensor_y:, beacon_x:, beacon_y:)
    @x = sensor_x
    @y = sensor_y

    @beacon_x = beacon_x
    @beacon_y = beacon_y

    @range = (beacon_x - x).abs + (beacon_y - y).abs
  end

  def perimeter_slopes_and_y_intercepts
    [
      [
        [ 1, y + range + 1 + x],
        [ 1, y + range + 1 - x]
      ],
      [
        [-1, y + range + 1 + x],
        [-1, y + range + 1 - x]
      ]
    ]
  end

  def cover?(point)
    distance_to_point = (point[0] - x).abs + (point[1] - y).abs

    distance_to_point <= range
  end

  def coverage_at_row(row_y)
    coverage = (x - (range - (row_y - y).abs) .. x + (range - (row_y - y).abs)).to_a
    coverage = coverage - [beacon_x] if beacon_y == row_y
    coverage = coverage - [x] if y == row_y

    coverage
  end

end
