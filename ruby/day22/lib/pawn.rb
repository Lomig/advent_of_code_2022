# frozen_string_literal: true

class Pawn
  TURN = {
    "L" => +1i,
    "R" => -1i
  }.freeze

  FACING_VALUES = {
     0 + 1i => 0,
     1 + 0i => 1,
     0 - 1i => 2,
    -1 + 0i => 3
  }.freeze

  attr_writer :moves, :direction
  attr_accessor :position

  private attr_reader :board, :moves, :direction

  def initialize(board:)
    @board = board
    board.pawn = self

    @moves = []
    @direction = 1i
  end

  def walk_path!
    next_move! until moves.empty?

    self
  end

  def password = 1_000 * (position.x + 1) + 4 * (position.y + 1) + FACING_VALUES[direction]

  private

  def next_move!
    next_move = moves.shift
    return turn(next_move) unless next_move.is_a?(Numeric)

    walk(next_move)
  end

  def turn(rotation)
    self.direction *= TURN[rotation]
  end

  def walk(times) = times.times { board.try_move(direction:) }
end
