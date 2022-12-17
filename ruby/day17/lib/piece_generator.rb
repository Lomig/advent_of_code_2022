# frozen_string_literal: true

require_relative "horizontal_piece"
require_relative "plus_piece"
require_relative "l_piece"
require_relative "vertical_piece"
require_relative "square_piece"

class PieceGenerator
  attr_writer :chamber

  private attr_reader :chamber, :pieces

  def initialize
    @pieces = [HorizontalPiece, PlusPiece, LPiece, VerticalPiece, SquarePiece].cycle.with_index
  end

  def next_with_index(spawn_row:) = pieces.next.then { |(piece, index)| [piece.new(chamber:, spawn_row:), index % 5] }
end
