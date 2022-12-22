# frozen_string_literal: true

class BoardParser
  PATH = /(\d+)(R|L)?/

  TYPES = {
    "#" => :wall,
    "." => :floor
  }.freeze

  private attr_reader :board, :pawn, :tile_class

  def initialize(board:, pawn:, tile_class:)
    @board = board
    @pawn = pawn
    @tile_class = tile_class
  end

  def parse(input)
    input.each_cons(2).with_index do |(line, extra_line), row_index|
      next parse_path(extra_line) if line.empty?

      parse_board_row(line, row_index)
    end
  end

  private

  def parse_path(line)
    pawn.moves = line.scan(PATH)
                     .map { |(walk, turn)| [walk.to_i, turn] }
                     .flatten.compact
  end

  def parse_board_row(row, row_index)
    row.chars.each_with_index do |tile, column_index|
      next if tile == " "

      board << tile_class.new(row_index, column_index, type: TYPES[tile])
      board.set_starting_position_unless_already(row_index, column_index)
    end
  end
end
