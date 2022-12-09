# frozen_string_literal: true

class Knot
  attr_reader :grid

  private attr_reader :position
  private attr_accessor :companion

  def initialize(grid:)
    @grid = grid
    @position = grid.starting_point
  end

  def add_companion(knot)
    raise ArgumentError if companion

    self.companion = knot
  end

  def move(direction:, times: 1) = times.times { self.position = grid.point_from(point: position, direction:) }

  def move_towards(new_position) = self.tap do
    self.position = grid.point_towards(point: position, target: new_position)

    position.visit! unless companion
  end

  private 

  def position=(new_position)
    @position = new_position
    move_companion! if companion
  end

  def move_companion! = self.tap { companion.move_towards(position) }
end
