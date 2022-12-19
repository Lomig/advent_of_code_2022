# frozen_string_literal: true

class BlueprintParser
  private attr_reader :blueprint

  def initialize(klass:)
    @blueprint = klass
  end

  def parse(input)
    input.map { |line| blueprint.new(*line.scan(/\d+/).map(&:to_i)) }
  end
end
