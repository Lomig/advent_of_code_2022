# frozen_string_literal: true

require_relative "../aoc"

class Day4 < AoC
  def result1
    input.count do |pair|
      first_elf_range, second_elf_range = split_ranges(pair)

      (first_elf_range - second_elf_range).empty? || (second_elf_range - first_elf_range).empty?
    end
  end

  def result2
    input.count do |pair|
      first_elf_range, second_elf_range = split_ranges(pair)

      first_elf_range.intersect?(second_elf_range) || second_elf_range.intersect?(first_elf_range)
    end
  end

  private

  def split_ranges(pair) = pair.split(",").map(&create_range)

  def create_range = lambda { |range|
    range.split("-")
         .then { |bound| [*bound.first..bound.last] }
  }
end
