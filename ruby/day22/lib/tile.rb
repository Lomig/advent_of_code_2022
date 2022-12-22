# frozen_string_literal: true

class Tile
  attr_reader :x, :y, :type

  def initialize(x, y, type: :none)
    @x = x
    @y = y
    @type = type
  end

  def as_complex = Complex(x, y)

  def wall?
    type == :wall
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def to_s = "(#{x},#{y})"
  alias inspect to_s
end
