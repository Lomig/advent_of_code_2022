# frozen_string_literal: true

require_relative "position"

class FieldParser
  private attr_reader :field, :elf_class

  def initialize(field:, elf_class:)
    @field = field
    @elf_class = elf_class
  end

  def parse(input)
    input.each_with_index do |row, y|
      row.chars.each_with_index do |position, x|
        next unless position == "#"

        field << elf_class.new(Position[x, y])
      end
    end
  end
end
