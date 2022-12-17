# frozen_string_literal: true

require_relative "piece"

class SquarePiece < Piece
  def bottom = [[0, 0], [1, 0]].map { |vector| origin + vector }
  def left = [[0, 0], [0, 1]].map { |vector| origin + vector }
  def right = [[1, 0], [1, 1]].map { |vector| origin + vector }

  def points = [[0, 0], [1, 0], [0, 1], [1, 1]].map { |vector| origin + vector }
end
