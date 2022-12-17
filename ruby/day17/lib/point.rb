# frozen_string_literal: true

class Point < Struct.new(:x, :y)
  def below = Point.new(x, y - 1)
  def above = Point.new(x, y + 1)
  def on_left = Point.new(x - 1, y)
  def on_right = Point.new(x + 1, y)
  def +(array) = Point.new(x + array[0], y + array[1])
end
