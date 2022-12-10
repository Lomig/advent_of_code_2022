# frozen_string_literal: true

require_relative "../aoc"

class Day1 < AoC
  def result1 = group_calories.max

  def result2 = group_calories.max(3).sum

  private

  def group_calories
    input.slice_when { |calories_value, _| calories_value.empty? }
         .map { |elf_inventory| elf_inventory.sum(&:to_i) }
  end
end
