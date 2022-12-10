# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/cpu"
require_relative "lib/cpu_probe"
require_relative "lib/clock"
require_relative "lib/crt"

class Day10 < AoC
  def result1
    probe = Probe.new
    clock, _ = setup_motherboard(probe:)

    clock.run!
    probe.signal_strength
  end

  def result2
    clock, cpu = setup_motherboard

    crt = CRT.new(cpu:)
    clock.register(crt)

    clock.run!
    crt.display
  end

  def setup_motherboard(probe: nil)
    clock = Clock.new

    cpu = CPU.new(probe:)
    cpu.load_instructions(input)

    clock.register(cpu)

    [clock, cpu]
  end
end
