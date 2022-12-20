# frozen_string_literal: true

class UniqueValue
  def initialize(x)
    @x = x
  end

  def ! = @x

  def self.[](x) = new(x)
end
