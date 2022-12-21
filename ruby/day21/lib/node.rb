# frozen_string_literal: true

class Node
  attr_reader :name, :left, :right

  attr_accessor :value, :operations, :parent

  def initialize(name:)
    @name = name
    @unknown = false
  end

  def compute_values!
    return value unless operations

    left.compute_values!
    right.compute_values!

    return nil if unknown?

    @value = operations[:operation].call(left.value, right.value)
  end

  def propagate_value!
    return unless operations
    return propagate_left if left.unknown?

    propagate_right if right.unknown?
  end

  def left=(other)
    @left = other
    other.parent = self
  end

  def right=(other)
    @right = other
    other.parent = self
  end

  def unknown!
    @unknown = true
    parent&.unknown!
  end

  def unknown? = @unknown

  private

  def propagate_left
    left.value = operations[:l_reverse].call(value, right.value)
    left.propagate_value!
  end

  def propagate_right
    right.value = operations[:r_reverse].call(value, left.value)
    right.propagate_value!
  end
end
