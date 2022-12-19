# frozen_string_literal: true

require_relative "../state"
require_relative "../resources"

class ObsidianRobotState < State
  @robots = Resources[0, 0, 1, 0]
  @robot_type = :obsidian_robot

  def or_skip_it
    return if robots[1].zero?
    return if robots[2] > @@state_manager.blueprint.max_obsidian_robot_needed
    return if round > @@state_manager.max_round

    self
  end
end
