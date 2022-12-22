# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/board"
require_relative "lib/cube"
require_relative "lib/pawn"
require_relative "lib/tile"
require_relative "lib/board_parser"

class Day22 < AoC
  def result1 = find_password_for(Board.new)

  def result2 = find_password_for(Cube.new)

  private

  def find_password_for(board)
    pawn = Pawn.new(board:)
    BoardParser.new(board:, pawn:, tile_class: Tile).parse(input)

    board.populate_edges!

    pawn.walk_path!
        .password
  end
end
