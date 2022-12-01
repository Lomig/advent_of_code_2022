# frozen_string_literal: true


class AnyInputReader
  private attr_reader :input

  def initialize(input)
    @input = sanitize_input(input)
  end

  def read = File.readlines(input, chomp: true)

  private

  def sanitize_input(input) = input
end

class DailyInputReader < AnyInputReader
  private

  def sanitize_input(input) = "day#{input}_input.txt"
end

class InputReader
  INPUT_READERS = {
    day_number: ::DailyInputReader,
    full_name: ::AnyInputReader
  }

  private attr_reader :input

  def initialize(args = {})
    @input = INPUT_READERS[args.keys.first].new(args.values.first)
  end

  def read = input.read

  def read_as_integers = input.read.map(&:to_i)
end
