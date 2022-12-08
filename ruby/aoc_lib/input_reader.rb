# frozen_string_literal: true

require "matrix"

class RawInputReader
  private attr_reader :file_name, :formatter

  def initialize(file_name:, formatter:)
    @file_name = file_name
    @formatter = formatter
  end

  def read = File.read(file_name).map(&formatter)
end

class ArrayReader < RawInputReader
  def read = File.readlines(file_name, chomp: true).map(&formatter)
end

class MatrixReader < RawInputReader
  def read
    File.open(file_name)
        .each_char
        .with_object([[]], &populate_matrix)
        .then { |matrix| Matrix[*matrix] }
  end

  def populate_matrix = lambda { |char, matrix|
    next matrix << [] if char == "\n"

    matrix.last << char.send(formatter)
  }
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
