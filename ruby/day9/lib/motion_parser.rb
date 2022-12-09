# frozen_string_literal: true

class MotionParser
  DIRECTIONS = {
    "U" => :up,
    "R" => :right,
    "D" => :down,
    "L" => :left
  }.freeze

  def parse(motions) = motions.map(&split_motion)

  private

  def split_motion = lambda { |motion|
    motion.split
          .then { |(direction, times)| [DIRECTIONS[direction], times.to_i] }
  }
end
