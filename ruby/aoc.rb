# frozen_string_literal: true

require 'forwardable'

require_relative "aoc_lib/input_reader"

class AoC
  extend Forwardable

  private attr_reader :reader, :input

  def initialize
    @reader = InputReader.new(
      file_name: "#{self.class.name.downcase}_input.txt",
      structure: self.class.structure || :array,
      formatter: self.class.formatter || :itself
    )

    @input = @reader.read
  end

  def_delegators :reader, :raw_input

  class << self
    attr_reader :structure, :formatter

    def input_as(structure, formatter: nil)
      @structure = structure
      @formatter = formatter
    end
  end
end
