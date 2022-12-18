# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/cube"
require_relative "lib/water"

class Day18 < AoC
  def result1
    input.map { |line| Cube.new(*line.split(?,).map(&:to_i)) }
         .combination(2).sum { |cube1, cube2| cube1.adjacent?(cube2) ? 2 : 0 }
         .then { |covered_faces| input.size * 6 - covered_faces }
  end

  def result2
    size = input.map { |l| l.split(?,).map(&:to_i) }.flatten.max
    droplets = input.map { |line| Cube.new(*line.split(?,).map(&:to_i), type: :droplet) }

    Water.new(size:, droplets:)
         .flood!
         .droplet_surfaces
  end
end
