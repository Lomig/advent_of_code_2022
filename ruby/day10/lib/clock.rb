# frozen_string_literal: true

class Clock
  private attr_reader :registered_components
  private attr_accessor :cycle

  def initialize
    @cycle = 0
    @registered_components = []
  end

  def register(component)
    registered_components << component
  end

  def tick
    self.cycle += 1
    registered_components.each { |component| component.on_tick(cycle) }
  end

  def run!
    tick until registered_components.all?(&:idle?)
  end
end
