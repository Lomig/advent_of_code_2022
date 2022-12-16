# frozen_string_literal: true

require_relative "valve"

class ValveParser
  REGEXP = /Valve (?<name>.{2}) has flow rate=(?<flow_rate>\d+); tunnels? leads? to valves? (?<edges>([A-Z]{2},? ?)+)/
  
  private attr_reader :volcano

  def initialize(volcano:)
    @volcano = volcano
  end

  def parse(input)
    input
      .map { |line| line.match(REGEXP) }
      .each do |match|
        Valve.new(name: match[:name], flow_rate: match[:flow_rate].to_i)
             .tap { |valve| volcano.add_valve(valve, edges: match[:edges].split(", ")) }
             .tap { |valve| volcano.starting_point = valve if valve.name == "AA"}
      end

    volcano
  end
end
