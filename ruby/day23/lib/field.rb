# frozen_string_literal: true

require_relative "position"

class Field
  private attr_reader :elf_class, :elves

  def initialize(elf_class:)
    @elf_class = elf_class
    @elves = {}
  end

  def <<(elf)
    elves[elf.position] = elf
    elf.field = self
  end

  def occupied?(position) = elves[position]

  def move_for(rounds:)
    rounds.times { move! }

    self
  end

  def move_until_still
    moves = 0

    loop do
      moves += 1

      return moves if move! == :still
    end
  end

  def empty_ground_tiles = rectangle_area - elves.values.compact.size

  def update(elf)
    elves[elf.former_position] = nil if elves[elf.former_position] == elf
    elves[elf.position] = elf
  end

  private

  def rectangle_area
    elves.filter_map { |position, elf| position if elf }
         .then { |positions| Position.encompass(positions) }
         .then { |((x_min, x_max), (y_min, y_max))| (x_max - x_min + 1) * (y_max - y_min + 1) }
  end

  def move!
    elves.values.each_with_object({}) { |elf, movements| elf.prepare_move(movements) if elf }
         .tap { |movements| return :still if movements.values.compact.empty? }
         .each { |position, elf| elf&.move_at(position) }

    elf_class.update_considerations!
  end
end
