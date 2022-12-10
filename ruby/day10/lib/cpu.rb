# frozen_string_literal: true

require_relative "clockable"
require_relative "cpu_instruction_set"

class CPU
  include Clockable
  include CPUInstructionSet

  attr_reader :x

  private attr_reader :execution_queue, :probe
  private attr_writer :x

  def initialize(probe: nil)
    @x = 1
    @execution_queue = []
    @is_idle = false

    @probe = probe
  end

  def on_tick(cycle)
    super

    pry_register(cycle)
    execute_instruction!(execution_queue.shift)

    halt! if execution_queue.empty?
  end

  def load_instructions(instructions) = instructions.each(&add_to_instruction_queue)

  private

  def pry_register(cycle)
    probe << [cycle, x] if probe
  end

  def add_to_instruction_queue = lambda { |instruction|
    instruction, value = instruction.split

    (INSTRUCTION_SET[instruction] - 1).times { execution_queue << nil }
    execution_queue << [send(instruction), value.to_s.split]
  }

  private

  def execute_instruction!(instruction)
    return unless instruction

    instruction.first.call(*instruction.last)
  end
end
