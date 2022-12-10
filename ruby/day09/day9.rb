# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/grid"
require_relative "lib/knot"
require_relative "lib/rope"
require_relative "lib/motion_parser"


###############################################################################
## DAY 9
###############################################################################

class Day9 < AoC
  def result1 = count_tail_visits

  def result2 = count_tail_visits(knot_quantity: 10)

  private

  def count_tail_visits(knot_quantity: 2)
    Grid.new
        .then { |grid| Knot.new(grid:)}
        .then { |head| Rope.new(head:, knot_quantity:)}
        .tap  { |rope| rope.move!(MotionParser.new.parse(input)) }
        .tail_positions
        .length
  end

end
