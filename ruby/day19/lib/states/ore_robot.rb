# frozen_string_literal: true

require_relative "../state"
require_relative "../resources"

class OreRobotState < State
  @robots = Resources[1, 0, 0, 0]
  @robot_type = :ore_robot

  def or_skip_it
    return if robots[0] > @@state_manager.blueprint.max_ore_robot_needed
    return if round > @@state_manager.max_round

    self
  end
end
