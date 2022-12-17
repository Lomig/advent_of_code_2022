# frozen_string_literal: true

require_relative "point"

class Piece
  private attr_reader :chamber
  private attr_accessor :origin

  def initialize(chamber:, spawn_row:)
    @chamber = chamber
    @origin = Point.new(2, spawn_row)
  end

  def down!
    return lock! if bottom.map(&:below).any? { |point| chamber.occupied?(point) }

    self.origin = origin.below
  end

  def left!
    return if left.map(&:on_left).any? { |point| chamber.occupied?(point) }

    self.origin = origin.on_left
  end

  def right!
    return if right.map(&:on_right).any? { |point| chamber.occupied?(point) }

    self.origin = origin.on_right
  end

  def to_s = "#{self.class.name}<#{origin.x}, #{origin.y}>"
  alias :inpect :to_s

  private

  def lock! = self.tap { chamber.lock(points) }
end
