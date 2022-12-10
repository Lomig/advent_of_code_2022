# frozen_string_literal: true

class Forest
  attr_reader :matrix

  def initialize(input)
    @matrix = input
  end

  def count_visible_from_outside
    matrix.each_with_index.count do |tree_height, r, c|
      next true if tree_at_edge?(row: r, column: c)

      visible_from_outside?(height: tree_height, position: c, column_or_row: matrix.row(r)) ||
      visible_from_outside?(height: tree_height, position: r, column_or_row: matrix.column(c))
    end
  end

  def best_scenic_view
    matrix.each_with_index.map do |tree_height, r, c|
      scenic_view(height: tree_height, position: c, column_or_row: matrix.row(r)) *
      scenic_view(height: tree_height, position: r, column_or_row: matrix.column(c))
    end.max
  end

  private

  def tree_at_edge?(row:, column:)
    return true if row.zero? || column.zero?

    row == matrix.row_count - 1 || column == matrix.column_count - 1
  end

  def visible_from_outside?(height:, position:, column_or_row:)
    left_end = column_or_row[...position]
    right_end = column_or_row[position + 1..]

    left_end.max < height || right_end.max < height
  end

  def scenic_view(height:, position:, column_or_row:)
    left_end = column_or_row[...position]
    right_end = column_or_row[position + 1..]

    left_visible_trees = left_end.reverse.take_while { |tree_height| tree_height < height }
    right_visible_trees = right_end.take_while { |tree_height| tree_height < height }

    count_trees(tree_line: left_end, visible_trees_in_line: left_visible_trees) *
    count_trees(tree_line: right_end, visible_trees_in_line: right_visible_trees)
  end

  def count_trees(tree_line:, visible_trees_in_line:)
    return tree_line.count if tree_line.count == visible_trees_in_line.count

    visible_trees_in_line.count + 1
  end
end
