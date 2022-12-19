# frozen_string_literal: true

class Resources
  include Enumerable

  attr_reader :x, :y, :z, :u

  def initialize(x = 0, y = 0, z = 0, u = 0)
    @x = x
    @y = y
    @z = z
    @u = u
  end

  def self.[](x, y, z, u) = new(x, y, z, u)

  def [](n) = [x, y, z, u][n]

  def -(other)
    Resources.new(x - other.x, y - other.y,
                  z - other.z, u - other.u)
  end

  def +(other)
    Resources.new(x + other.x, y + other.y,
                  z + other.z, u + other.u)
  end

  def *(other)
    other = Resources[other, other, other, other] if other.is_a?(Numeric)

    Resources.new(x * other.x, y * other.y,
                  z * other.z, u * other.u)
  end

  def opposite = Resources.new(-x, -y, -z, -u)

  def each(&block) = [x, y, z, u].each(&block)

  def to_s = "#{x}, #{y}, #{z}, #{u}"
  alias inspect to_s
end
