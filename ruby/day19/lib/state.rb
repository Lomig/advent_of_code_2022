# frozen_string_literal: true

require_relative "resources"

class State
  @robots = ::Resources.new
  @robot_type = nil

  attr_reader :robots, :resources, :round, :parent

  def initialize(robots:, resources:, round:, parent: nil)
    @robots = robots
    @resources = resources
    @round = round
    @parent = parent
  end

  def geodes = resources[3]

  def produce_resources_in_time(robot_type)
    debt = resources - @@state_manager.blueprint.cost(robot_type)
    time = [0, *time_needed_to_reimburse_debt(debt, robots)].max + 1

    [
      debt + (robots * time),
      round + time
    ]
  end

  def to_s = "State<round :#{round}, robots: [#{robots}], resources:[#{resources}]>"
  alias inspect to_s

  private

  def time_needed_to_reimburse_debt(debt, robots)
    debt.zip(robots).map { |(d, r)| d.fdiv(-r).ceil rescue 0 }
  end

  #############################################################################
  ## CLASS METHODS
  #############################################################################

  class << self
    def next_robot
      @next_robot ||=
        {
          ore: OreRobotState,
          clay: ClayRobotState,
          obsidian: ObsidianRobotState,
          geode: GeodeRobotState
        }.freeze
    end

    def from(other)
      robots = other.robots + @robots
      resources, round = other.produce_resources_in_time(@robot_type)

      resources = resources_without_geode_update(other.resources, resources)
      new(robots:, resources:, round:, parent: other).or_skip_it
    end

    def state_manager=(state_manager)
      @@state_manager = state_manager
    end

    private

    def resources_without_geode_update(previous, current)
      Resources[current[0], current[1], current[2], previous[3]]
    end
  end
end

require_relative "states/ore_robot"
require_relative "states/clay_robot"
require_relative "states/obsidian_robot"
require_relative "states/geode_robot"
