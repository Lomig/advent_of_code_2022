# frozen_string_literal: true

##########################
# 0 1 2 3 4 5 6 7 8 9 10
# . . . . . . . . . . .  0
# . . . . . . . . . . .  1
# . . . . . # . . . . .  2
# . . . . # # # . . . .  3
# . . . # # # # # . . .  4
# . . # # # S # # # . .  5
# . . . # # # # B . . .  6
# . . . . # # # . . . .  7
# . . . . . # . . . . .  8
# . . . . . . . . . . .  9
# . . . . . . . . . . . 10
# . . |---| <- range

# S : Sensor with coordinates Xs, Ys
# B : Beacon with coordinates Xb, Yb
# range = |Xb - Xs| + |Yb - Ys|

# As the solution is unique, the beacon will be just outside of range of at least 2 sensors
# It will be on a point just outside a detection zone, on its perimeter
# 4 possibilities:
#    - On the segment going from (1, 8) to (5, 4)
#    - On the segment going from (5, 4) to (9, 8)
#    - On the segment going from (9, 8) to (5,12)
#    - On the segment going from (5,12) to (1, 8)

# Let's express those numbers in terms of Sensors:
#    - Segment from (Xs - range - 1, Ys) to (Xs, Ys - range - 1)
#    - Segment from (Xs, Ys - range - 1) to (Xs + range + 1, Ys)
#    - Segment from (Xs + range + 1, Ys) to (Xs, Ys + range + 1)
#    - Segment from (Xs, Ys + range + 1) to (Xs - range - 1, Ys)

# To find where two segments can intersect, we need the equation describing the segment.
# It will conform to y = a x + b
# Here, it follows a Manhattan path, so a = 1 or a = -1

#  y = ∓ x + b
# Ys = ∓ (Xs + range + 1) + b
#  b = Ys ∓ (Xs + range + 1)

# y = ∓ x + b
# Ys + range + 1 = ∓ Xs + b
# b = Ys + range + 1 ∓ Xs

# Find intersection of two segments :
# | y = S1a x + S1b
# | y = S2a x + S2b

# | ----------------
# | 0 = x(S1a - S2a) + S1b - S2b

# x = (S2b - S1b) / (S1a - S2a)

#      S2a (S2b - S1b)
# y = ----------------- + S2b
#         S1a - S2a

# The algorithm will then be:
# 1 - For each Sensor, compute a (the slope) and b (the y-intercept) for the 4 segments
# 2 - A segment cannot intersect another with the same slope, separate both in two groups
# 3 - For each group, find all intersections within the given grid
# 4 - Find an intersection that is not within the range of a sensor

require_relative "../aoc"
require_relative "lib/sensor_parser"

class Day15 < AoC
  ZONE_SIZE = 4_000_000

  def result1
    sensors = SensorParser.new.parse(input)

    sensors.map { |sensor| sensor.coverage_at_row(ZONE_SIZE / 2) }
           .flatten
           .uniq
           .count
  end

  def result2
    sensors = SensorParser.new.parse(input)

    sensors.reduce([[], []], &method(:perimeter_slopes_and_y_intercepts_by_slope_direction))
           .then(&method(:create_intersections))
           .find { |intersection| sensors.none? { |sensor| sensor.cover?(intersection) } }
           .then { |x, y| x * 4_000_000 + y }
  end

  private

  def perimeter_slopes_and_y_intercepts_by_slope_direction((slopes_and_intercept1, slopes_and_intercept2), sensor)
    sensor
      .perimeter_slopes_and_y_intercepts
      .then { |slope_groups| [slopes_and_intercept1 + slope_groups[0], slopes_and_intercept2 + slope_groups[-1]] }
  end

  def create_intersections(slopes_and_y_intercepts_by_slope_direction)
    slopes_and_y_intercepts_by_slope_direction[0].each_with_object([]) do |(a_s1, b_s1), intersections|
      slopes_and_y_intercepts_by_slope_direction[1].each do |(a_s2, b_s2)|
        x_intersection = (b_s2 - b_s1) / (a_s1 - a_s2)
        y_intersection = b_s2 + ((a_s2 * (b_s2 - b_s1)) / (a_s1 - a_s2))

        next if x_intersection < 0 || x_intersection > ZONE_SIZE
        next if y_intersection < 0 || y_intersection > ZONE_SIZE

        intersections << [x_intersection, y_intersection]
      end
    end
  end
end
