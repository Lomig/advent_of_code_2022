# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/forest"

class Day8 < AoC
  input_as :matrix, formatter: :to_i

  def result1 = Forest.new(input).count_visible_from_outside

  def result2 = Forest.new(input).best_scenic_view
end
