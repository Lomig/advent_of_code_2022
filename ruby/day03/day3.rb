# frozen_string_literal: true

require_relative "../aoc"

class Day3 < AoC
  PRIORITIES = [nil, *("a".."z"), *("A".."Z")].freeze

  def result1
    input.sum do |rucksack|
      rucksack.chars
              .each_slice(rucksack.size / 2)
              .reduce(&:&)
              .then { |duplicate_items| PRIORITIES.index(duplicate_items.first) }
    end
  end

  def result2
    input
      .each_slice(3)
      .sum { |group_of_three| PRIORITIES.index(unique_duplicate_item_of(group_of_three)) }
  end

  private

  def unique_duplicate_item_of(group) = group.map(&:chars).reduce(&:&)[0]
end
