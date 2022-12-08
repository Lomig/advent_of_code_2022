# frozen_string_literal: true

require_relative "aoc_lib/input_reader"

class AoC
  private attr_reader :input

  def initialize
    @input = InputReader.new(
      file_name: "#{self.class.name.downcase}_input.txt",
      structure: self.class.structure || :array,
      formatter: self.class.formatter || :itself
    ).read
  end

  class << self
    attr_reader :structure, :formatter

    def input_as(structure, formatter: nil)
      @structure = structure
      @formatter = formatter
    end
  end
end
