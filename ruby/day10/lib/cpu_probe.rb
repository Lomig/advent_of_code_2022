# frozen_string_literal: true

class Probe
  private attr_reader :logs

  def initialize
    @logs = Array.new(0)
  end

  def <<(cycle_and_register_value)
    logs[cycle_and_register_value.first] = cycle_and_register_value.last
  end

  def signal_strength
    logs.each_with_index.sum { |(value, cycle)| cycle % 40 == 20 ? cycle * value.to_i : 0 }
  end
end