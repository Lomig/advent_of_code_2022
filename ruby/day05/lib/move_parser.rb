# frozen_string_literal: true

class MoveParser
  MOVE = /move (?<times>\d+) from (?<from_stack>\d+) to (?<to_stack>\d+)/

  def parse(input) = input.map { |line| parse_line_of_move(line) }

  private

  def parse_line_of_move(move)
    move.match(MOVE)
        .then { |match| Hash[[match.names.map(&:to_sym), match.captures.map(&:to_i)].transpose] }
  end
end
