# frozen_string_literal: true

require_relative "../aoc"

class Day6 < AoC
  def result1 = detect_marker(size: 4)

  def result2 = detect_marker(size: 14)

  private

  def detect_marker(size:) = input[0].chars.each_cons(size).with_index { |m, i| break i + size if m.size == m.uniq.size }
end
