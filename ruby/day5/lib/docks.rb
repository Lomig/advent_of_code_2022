# frozen_string_literal: true

class Docks
  private attr_reader :stacks

  def initialize(crates)
    @stacks = stack!(crates)
  end

  def move(times:, from_stack:, to_stack:) = times.times { stacks[to_stack - 1] << stacks[from_stack - 1].pop }

  def power_move(times:, from_stack:, to_stack:) = (stacks[to_stack - 1] << stacks[from_stack - 1].pop(times)).flatten!

  def top_crates = stacks.reduce("") { |result, stack| "#{result}#{stack.last}" }

  private

  def stack!(crates) = crates.reverse.transpose.map { |stacks| stacks.reject(&:empty?) }
end
