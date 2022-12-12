# frozen_string_literal: true

class Map
  private attr_reader :matrix, :starting_points, :ending_point

  def initialize(matrix:, starting_points:, ending_point:)
    @matrix = matrix
    @starting_points = starting_points
    @ending_point = ending_point
  end

  def shortest_path_from_starting_points = starting_points.map(&shortest_path).min

  private

  def shortest_path = lambda do |starting_point|
    matrix.each(&:reset!)

    starting_point.distance_from_start = 0
    queue = [starting_point]
    
    queue = compute_distances_for_nodes_from(queue) until queue.empty? || ending_point.visited?

    ending_point.distance_from_start
  end

  def compute_distances_for_nodes_from(queue)
    queue.shift
         .tap { |current_node| current_node.visit! }
         .then { |current_node| neighbour_nodes(current_node).compact }
         .then { |nodes| (queue + nodes).uniq }
  end

  def neighbour_nodes(current_node)
    current_node.neighbours.map do |node|
      next if node.visited?

      new_distance_from_start = current_node.distance_from_start + 1
      node.distance_from_start = [node.distance_from_start, new_distance_from_start].min

      node
    end  
  end
end
