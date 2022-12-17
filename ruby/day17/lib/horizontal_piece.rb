# frozen_string_literal: true

require_relative "piece"

class HorizontalPiece < Piece
  def bottom = [[0, 0], [1, 0], [2, 0], [3, 0]].map { |vector| origin + vector }
  def left = [origin]
  def right = [origin + [3, 0]]

  def points = [[0, 0], [1, 0], [2, 0], [3, 0]].map { |vector| origin + vector }
end
