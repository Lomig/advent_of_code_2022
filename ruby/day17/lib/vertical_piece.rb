# frozen_string_literal: true

require_relative "piece"

class VerticalPiece < Piece
  def bottom = [origin]
  def left = [[0, 0], [0, 1], [0, 2], [0, 3]].map { |vector| origin + vector }
  def right = [[0, 0], [0, 1], [0, 2], [0, 3]].map { |vector| origin + vector }

  def points = [[0, 0], [0, 1], [0, 2], [0, 3]].map { |vector| origin + vector }
end
