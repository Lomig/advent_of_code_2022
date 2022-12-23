# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/field"
require_relative "lib/field_parser"
require_relative "lib/elf"

class Day23 < AoC
  def result1
    Field.new(elf_class: Elf)
         .tap { |field| FieldParser.new(field:, elf_class: Elf).parse(input.reverse) }
         .move_for(rounds: 10)
         .empty_ground_tiles
  end

  def result2
    Field.new(elf_class: Elf)
         .tap { |field| FieldParser.new(field:, elf_class: Elf).parse(input.reverse) }
         .move_until_still
  end
end
