# frozen_string_literal: true

class Elf
  @considerations = %w[check_north check_south check_west check_east]

  attr_reader :position, :former_position
  attr_writer :field

  private attr_reader :field
  private attr_writer :position, :former_position
  private attr_accessor :surroundings

  def initialize(position)
    @position = position
    @surroundings = []
  end

  def move_at(new_position)
    return unless new_position

    self.former_position = position
    self.position = new_position
    field.update(self)
  end

  def prepare_move(movements)
    return if clear?

    Elf.considerations
       .filter_map { |consideration| send(consideration) }
       .first => next_position

    movements[next_position] = movements[next_position] ? nil : self
  end

  private

  def clear?
    self.surroundings = position.around.map { |pos| field.occupied?(pos) } * 2

    surroundings.uniq == [nil]
  end

  def check_north
    return if surroundings[7..9].any?

    position.north
  end

  def check_east
    return if surroundings[1..3].any?

    position.east
  end

  def check_south
    return if surroundings[3..5].any?

    position.south
  end

  def check_west
    return if surroundings[5..7].any?

    position.west
  end

  class << self
    attr_reader :considerations

    def update_considerations!
      considerations << considerations.shift
    end
  end
end
