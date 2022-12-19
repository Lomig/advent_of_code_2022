# frozen_string_literal: true

require_relative "../state"
require_relative "../resources"

class GeodeRobotState < State
  @robots = Resources[0, 0, 0, 1]
  @robot_type = :geode_robot

  def or_skip_it
    return if robots[2].zero?
    return if round > @@state_manager.max_round

    self
  end

  class << self
    def from(other)
      robots = other.robots + @robots
      resources, round = other.produce_resources_in_time(@robot_type)

      resources = resources_with_future_geodes(other.resources, resources, round)
      new(robots:, resources:, round:, parent: other).or_skip_it
    end

    def resources_with_future_geodes(previous, current, round)
      Resources[current[0], current[1], current[2], previous[3] + @@state_manager.max_round - round]
    end
  end
end
