# frozen_string_literal: true

module CPUInstructionSet
  INSTRUCTION_SET = {
    "addx" => 2,
    "noop" => 1
  }

  def addx = lambda { |v| self.x += v.to_i }

  def noop = lambda { nil }
end
