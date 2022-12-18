# frozen_string_literal: true

class Cube < Struct.new(:x, :y, :z)
  attr_reader :type

  def initialize(x, y, z, type: :unknown)
    super(x, y, z)
    @type = type
  end
  
  def -(other) = Cube.new(x - other.x, y - other.y, z - other.z)

  def abs = Cube.new(x.abs, y.abs, z.abs)

  def fold = x + y + z

  def adjacent?(other)
    (self - other).abs.fold == 1
  end

  def as_steam = Cube.new(x, y, z, type: :steam)

  def left = Cube.new(x - 1, y, z)
  def right = Cube.new(x + 1, y, z)
  def top = Cube.new(x, y, z + 1)
  def bottom = Cube.new(x, y, z - 1)
  def front = Cube.new(x, y - 1, z)
  def back = Cube.new(x, y + 1, z)
end
