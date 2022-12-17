# frozen_string_literal: true

require_relative "piece"

class LPiece < Piece
  def bottom = [[0, 0], [1, 0], [2, 0]].map { |vector| origin + vector }
  def left = [[0, 0], [2, 1], [2, 2]].map { |vector| origin + vector }
  def right = [[2, 0], [2, 1], [2, 2]].map { |vector| origin + vector }

  def points = [[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]].map { |vector| origin + vector }
end
