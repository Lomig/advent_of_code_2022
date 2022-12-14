# frozen_string_literal: true

class Tile
  attr_reader :x, :y, :type

  def initialize(x:, y:, type:)
    @x = x
    @y = y
    @type = type
  end

  def sand?
    type == :sand
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def to_s = "#{type.capitalize}<#{x},#{y}>"
  alias :inspect :to_s
end

def Tile(x, y, type: :sand) = Tile.new(x:, y:, type:)