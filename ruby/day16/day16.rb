# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/valve_parser"
require_relative "lib/volcano"

class Day16 < AoC
  def result1
    volcano = ValveParser.new(volcano: Volcano.new).parse(input)

    volcano.compute_all_distances!
           .find_max_flow_release(time: 30, valve: volcano.starting_point)
           .first
  end

  def result2
    volcano = ValveParser.new(volcano: Volcano.new).parse(input)

    volcano.compute_all_distances!
           .find_max_flow_release_with_elephant(time: 26, valve: volcano.starting_point)
  end
end
