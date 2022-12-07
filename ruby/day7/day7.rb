# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/custom_file"
require_relative "lib/directory"
require_relative "lib/computer"
require_relative "lib/instructions_parser"

class Day7 < AoC
  def result1 = computer.sum_directory_size_at_most(amount: 100_000)

  def result2 = computer.free_space(amount: 30_000_000)

  private

  def computer = Computer.new(instructions: InstructionsParser.new.parse(input), total_space: 70_000_000)
end
