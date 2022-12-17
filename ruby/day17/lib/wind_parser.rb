# frozen_string_literal: true

class WindParser
  DIRECTIONS = {
    ">" => :right!,
    "<" => :left!
  }

  def parse(input) = input.map { |wind| DIRECTIONS[wind] }
end
