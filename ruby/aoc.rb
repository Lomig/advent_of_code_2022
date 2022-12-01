# frozen_string_literal: true

require_relative "aoc_lib/input_reader"

class AoC
  private attr_reader :input

  def initialize
    @input = InputReader.new(day_number: self.class.name.gsub("Day", ""))
                        .read
  end
end
