# frozen_string_literal: true

class Rope
  private attr_reader :head, :grid

  def initialize(head:, knot_quantity: 2)
    @head = head

    add_tails!(quantity: knot_quantity - 1)
  end

  def move!(moves) = moves.each { |motion| head.move(direction: motion.first.to_sym, times: motion.last) }

  def tail_positions = head.grid.visited_points

  private

  def add_tails!(quantity:)
    quantity.times.reduce(head) do |head, _|
      Knot.new(grid: head.grid)
          .tap { |tail| head.add_companion(tail) }
    end
  end
end
