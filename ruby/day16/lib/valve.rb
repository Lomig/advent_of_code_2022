# frozen_string_literal: true

class Valve
  attr_reader :name, :flow_rate, :neighbours

  private attr_reader :visits

  def initialize(name:, flow_rate:)
    @name = name
    @flow_rate = flow_rate
    @neighbours = []

    @visits= {}
  end

  def add_neighbour(other)
    return unless other

    neighbours << other
    other.neighbours << self
  end

  def visited_from!(valve)
    visits[valve] = true
  end

  def visited_from?(valve) = visits[valve]

  def to_s = "Valve<#{name}, flow_rate: #{flow_rate}>"
  alias :inspect :to_s 
end
