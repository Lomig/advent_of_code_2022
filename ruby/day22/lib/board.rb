# frozen_string_literal: true

class Board
  attr_writer :pawn

  private attr_reader :board, :pawn

  def initialize
    @board = {}
  end

  def set_starting_position_unless_already(x, y)
    return if pawn.position

    pawn.position = board[Complex(x, y)]
  end

  def try_move(direction:)
    next_position = board[position.as_complex + direction]
    next_position ||= crawl_up_to_start(position:, direction:)

    return if next_position.wall?

    pawn.position = next_position
  end

  def populate_edges! = self

  def <<(tile)
    board[tile.as_complex] = tile
  end

  private

  def position = pawn.position

  def crawl_up_to_start(position:, direction:)
    new_position = board[position.as_complex - direction]
    return position unless new_position

    crawl_up_to_start(position: new_position, direction:)
  end
end
