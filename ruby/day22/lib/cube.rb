# frozen_string_literal: true

class Cube < Board
  private attr_reader :width, :edges

  def initialize
    super

    @edges = {}
  end

  def try_move(direction:)
    next_position = board[position.as_complex + direction]
    next_position, next_direction = edges[[position, direction]] unless next_position

    return super unless next_position
    return if next_position.wall?

    pawn.direction = next_direction if next_direction
    pawn.position = next_position
  end

  def populate_edges! = zippers.each { |zipper| zip_edges!(*zipper) }

  private

  def zippers
    board.each_with_object([]) do |(_, tile), zippers|
      [1 + 1i, 1 - 1i, -1 + 1i, -1 - 1i].each do |directions|
        zippers << [tile, directions.real.to_c, directions - directions.real] if zipper?(tile, directions)
      end
    end
  end

  def zipper?(tile, zip_directions)
    board[tile.as_complex + zip_directions.real] &&
      board[tile.as_complex + zip_directions - zip_directions.real] &&
      !board[tile.as_complex + zip_directions]
  end

  def zip_edges!(starting_point, left_direction, right_direction)
    left = board[starting_point.as_complex + left_direction]
    right = board[starting_point.as_complex + right_direction]

    left_turn = -right_direction
    right_turn = -left_direction

    left_already_in_corner = right_already_in_corner = false

    loop do
      create_edges(left, right, left_turn, right_turn)

      return if corner?(left) && corner?(right)

      if corner?(left) && !left_already_in_corner
        left_direction, left_turn = left_turn, -left_direction
        left_already_in_corner = true
      else
        left = board[left.as_complex + left_direction]
        left_already_in_corner = false
      end

      if corner?(right) && !right_already_in_corner
        right_direction, right_turn = right_turn, -right_direction
        right_already_in_corner = true
      else
        right = board[right.as_complex + right_direction]
        right_already_in_corner = false
      end
    end
  end

  def corner?(tile)
    [1, -1, 1i, -1i].count { |direction| board[tile.as_complex + direction] }
                    .then { |empty_tiles| empty_tiles == 2 }
  end

  def create_edges(left_tile, right_tile, left_turn, right_turn)
    edges[[left_tile, -left_turn]] = [right_tile, right_turn]
    edges[[right_tile, -right_turn]] = [left_tile, left_turn]
  end
end
