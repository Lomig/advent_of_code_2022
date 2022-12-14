# frozen_string_literal: true

class RockPathsParser
  def parse(input)
    input.map(&split_into_points)
  end

  def split_into_points = lambda do |paths|
    paths.split(" -> ")
         .map { |point| point.split(?,).map(&:to_i) }
         .each_cons(2)
  end
end
