# frozen_string_literal: true

require_relative "../state"
require_relative "../resources"

class ClayRobotState < State
  @robots = Resources[0, 1, 0, 0]
  @robot_type = :clay_robot

  def or_skip_it
    return if robots[1] > @@state_manager.blueprint.max_clay_robot_needed
    return if round > @@state_manager.max_round

    self
  end
end
