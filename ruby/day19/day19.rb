# frozen_string_literal: true

require "parallel"

require_relative "../aoc"

require_relative "lib/resources"

require_relative "lib/blueprint"
require_relative "lib/blueprint_parser"

require_relative "lib/state_manager"
require_relative "lib/state"

class Day19 < AoC
  def result1
    Parallel.map(blueprints) do |blueprint|
      StateManager.new(klass: State, blueprint:, max_round: 24)
                  .explore_states!
                  .quality_level
    end.sum
  end

  def result2
    Parallel.map(blueprints.first(3).map) do |blueprint|
      StateManager.new(klass: State, blueprint:, max_round: 32)
                  .explore_states!
                  .geodes
    end.reduce(&:*)
  end

  private

  def blueprints = BlueprintParser.new(klass: Blueprint).parse(input)
end
