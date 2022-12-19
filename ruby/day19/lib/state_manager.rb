# frozen_string_literal: true

require "pry-byebug"
require_relative "resources"

class StateManager
  attr_reader :blueprint, :max_round

  private attr_reader :klass, :queue, :max_at_round

  def initialize(klass:, blueprint:, max_round:)
    @klass = klass
    @klass.state_manager = self

    @blueprint = blueprint
    @max_round = max_round

    @max_at_round = Array.new(max_round + 1, 0)
    @queue = []
  end

  def quality_level = blueprint.name * geodes

  def geodes = max_at_round.max

  def explore_states!
    state = klass.new(robots: Resources[1, 0, 0, 0], resources: Resources[0, 0, 0, 0], round: 0)
    queue << state

    search_queue until queue.empty?

    self
  end

  private

  def search_queue
    current_state = queue.pop
    max_at_round[current_state.round] = [max_at_round[current_state.round], current_state.geodes].max

    return if current_state.round == max_round
    return if current_state.geodes < max_at_round[current_state.round]

    add_geode_robot_when_possible(current_state)
    return if geode_robot_added_for_next_round?(current_state.round)

    add_obsidian_robot_when_possible(current_state)
    add_clay_robot_when_possible(current_state)
    add_ore_robot_when_possible(current_state)
  end

  def add_geode_robot_when_possible(current_state)
    return unless (new_state = klass.next_robot[:geode].from(current_state))

    queue << new_state
  end

  def geode_robot_added_for_next_round?(current_round)
    next_robot_state = queue.last
    next_robot_state.is_a?(klass.next_robot[:geode]) && next_robot_state.round == current_round + 1
  end

  def add_obsidian_robot_when_possible(current_state)
    return unless (new_state = klass.next_robot[:obsidian].from(current_state))

    queue << new_state
  end

  def add_clay_robot_when_possible(current_state)
    return unless (new_state = klass.next_robot[:clay].from(current_state))

    queue << new_state
  end

  def add_ore_robot_when_possible(current_state)
    return unless (new_state = klass.next_robot[:ore].from(current_state))

    queue << new_state
  end
end
