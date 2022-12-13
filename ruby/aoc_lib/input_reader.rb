# frozen_string_literal: true

require "matrix"

class RawInputReader
  private attr_reader :file_name, :formatter

  def initialize(file_name:, formatter:)
    @file_name = file_name
    @formatter = formatter
  end

  def read
    if formatter.is_a?(Proc)
      formatter.call(raw_input)
    else
      raw_input.send(formatter)
    end
  end

  def raw_input = File.read(file_name)
end

class ArrayReader < RawInputReader
  def read = File.readlines(file_name, chomp: true).map(&formatter)
end

class MatrixReader < RawInputReader
  private attr_reader :row, :column

  def initialize(file_name:, formatter:)
    @row = @column = 0
    super
  end

  def read
    File.open(file_name)
        .each_char
        .with_object([[]], &populate_matrix)
        .then { |matrix| Matrix[*matrix] }
  end

  def populate_matrix = lambda { |char, matrix|
    if char == "\n"
      increase_row
      reset_column
      matrix << []
      next
    end

    if formatter.is_a?(Proc)
      matrix.last << formatter.call(char, row, column)
    else
      matrix.last << char.send(formatter)
    end

    increase_column
  }

  def increase_row
    @row += 1
  end

  def increase_column
    @column += 1
  end

  def reset_column
    @column = 0
  end
end

class InputReader
  INPUT_STRUCTURES = {
    raw: ::RawInputReader,
    array: ::ArrayReader,
    matrix: ::MatrixReader
  }.freeze

  private attr_reader :input

  def self.new(file_name:, structure:, formatter:)
    INPUT_STRUCTURES[structure].new(file_name:, formatter:)
  end
end
