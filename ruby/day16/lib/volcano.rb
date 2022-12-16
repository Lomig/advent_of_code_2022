# frozen_string_literal: true

require "parallel"

class Volcano
  attr_accessor :starting_point

  private attr_reader :valves, :distances, :investigated_already

  def initialize
    @valves = {}
    @distances = {}
    @investigated_already = []
  end

  def add_valve(valve, edges:)
    valves[valve.name] = valve
    edges.each { |edge| valve.add_neighbour(valves[edge]) }
  end

  def compute_all_distances!
    ([starting_point] + non_zero_valves).each(&method(:compute_distances_from_valve))

    self
  end

  def find_max_flow_release(time:, valve:, available_valves: non_zero_valves)
    available_valves.inject([0, []]) do |(max_flow, best_path), investigated_valve|
      time_remaining = time - distances[valve][investigated_valve] - 1

      next [max_flow, best_path] if time_remaining <= 0

      flow = investigated_valve.flow_rate * time_remaining
      flow_release_from_target, best_path_from_target = find_max_flow_release(time: time_remaining, valve: investigated_valve, available_valves: available_valves - [investigated_valve])
    
      flow += flow_release_from_target

      next [max_flow, best_path] unless flow > max_flow
      
      [flow, [valve] + best_path_from_target]
    end
  end

  def find_max_flow_release_with_elephant(time:, valve:)
    Parallel.map(path_combinations) do |elephant_path|
      find_max_flow_release(time:, valve:, available_valves: non_zero_valves - elephant_path).first +
      find_max_flow_release(time:, valve:, available_valves: elephant_path).first
    end.max
  end

  private

  def path_combinations
    Enumerator.new do |enums|
      (1 + non_zero_valves.size / 2).times do |n|
          non_zero_valves.combination(n).each do |combination|
              enums << combination
          end
      end
    end
  end

  def non_zero_valves
    @non_zero_valves ||=
      valves.values
            .reject { |valve| valve.flow_rate.zero? }
  end

  def compute_distances_from_valve(valve)
    distances[valve] = Hash.new(Float::INFINITY)
    distances[valve][valve] = 0
    queue = [valve]

    queue = compute_distances_for_valves_from(queue, origin: valve) until queue.empty?
  end

  def compute_distances_for_valves_from(queue, origin:)
    queue.shift
         .tap { |current_valve| current_valve.visited_from!(origin) }
         .then { |current_valve| neighbour_valves(current_valve, origin:).compact }
         .then { |nodes| (queue + nodes).uniq }
  end

  def neighbour_valves(current_valve, origin:)
    current_valve.neighbours.map do |valve|
      next if valve.visited_from?(origin)

      distances[origin][valve] = distances[origin][current_valve] + 1

      valve
    end  
  end
end
