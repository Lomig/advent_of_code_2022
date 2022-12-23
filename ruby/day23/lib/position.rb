# frozen_string_literal: true

class Position
  private attr_reader :position

  def initialize(position)
    @position = position
  end

  def to_c = position

  def north      = Position.new(position + 0 + 1i)
  def north_east = Position.new(position + 1 + 1i)
  def east       = Position.new(position + 1 + 0i)
  def south_east = Position.new(position + 1 - 1i)
  def south      = Position.new(position + 0 - 1i)
  def south_west = Position.new(position - 1 - 1i)
  def west       = Position.new(position - 1 + 0i)
  def north_west = Position.new(position - 1 + 1i)

  def north_quadrant = [north_west, north, north_east]
  def east_quadrant  = [north_east, east,  south_east]
  def south_quadrant = [south_east, south, south_west]
  def west_quadrant  = [south_west, west,  north_west]

  def around = [north, north_east, east, south_east, south, south_west, west, north_west]

  def ==(other)
    position == other.to_c &&
      self.class == other.class
  end
  alias eql? ==

  delegate :hash, to: :position

  def to_s = "Pos<#{position.real},#{position.imaginary}>"
  alias inspect to_s

  class << self
    def [](x, y) = new(Complex(x, y))

    def encompass(positions)
      positions
        .reduce([
                  [Float::INFINITY, -Float::INFINITY],
                  [Float::INFINITY, -Float::INFINITY]
                ]) do |((min_x, max_x), (min_y, max_y)), position|
        [
          [
            [min_x, position.to_c.real].min,
            [max_x, position.to_c.real].max
          ],
          [
            [min_y, position.to_c.imaginary].min,
            [max_y, position.to_c.imaginary].max
          ]
        ]
      end
    end
  end
end
