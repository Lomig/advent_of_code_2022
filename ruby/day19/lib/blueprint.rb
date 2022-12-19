# frozen_string_literal: true

require_relative "resources"

class Blueprint
  attr_reader :name, :max_ore_robot_needed, :max_clay_robot_needed, :max_obsidian_robot_needed

  private attr_reader :costs

  def initialize(name,
                 ore_robot_cost,
                 clay_robot_cost,
                 obsidian_robot_ore_cost, obsidian_robot_clay_cost,
                 geode_robot_ore_cost, geode_robot_obsidian_cost)
    @name = name
    @costs = {
      ore_robot: Resources[ore_robot_cost, 0, 0, 0],
      clay_robot: Resources[clay_robot_cost, 0, 0, 0],
      obsidian_robot: Resources[obsidian_robot_ore_cost, obsidian_robot_clay_cost, 0, 0],
      geode_robot: Resources[geode_robot_ore_cost, 0, geode_robot_obsidian_cost, 0]
    }

    @max_ore_robot_needed = costs.values.map(&:x).max
    @max_clay_robot_needed = costs.values.map(&:y).max
    @max_obsidian_robot_needed = costs.values.map(&:z).max
  end

  def cost(state) = costs[state]
end
