# frozen_string_literal: true

require_relative "piece"

class PlusPiece < Piece
  def bottom = [[0, 1], [1, 0], [2, 1]].map { |vector| origin + vector }
  def left = [[1, 0], [0, 1], [1, 2]].map { |vector| origin + vector }
  def right = [[1, 0], [2, 1], [1, 2]].map { |vector| origin + vector }

  def points = [[1, 0], [0, 1], [1, 1], [2, 1], [1, 2]].map { |vector| origin + vector }
end
