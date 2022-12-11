# frozen_string_literal: true

require_relative "../aoc"
require_relative "lib/monkey_creator"
require_relative "lib/canopy"

class Day11 < AoC
  def result1
    relax_method = ->(stress_level) { stress_level / 3 }
    
    monkey_play!(round: 20, relax_method:)
  end

  def result2
    relax_method = ->(stress_level) { stress_level % stress_level_congruence }
    
    monkey_play!(round: 10_000, relax_method:)
  end

  private

  def monkey_play!(round:, relax_method:)
    MonkeyCreator.generate_family(input, relax_method:)
                 .then { |monkeys| Canopy.new(monkeys:) } => canopy
    
    canopy.play!(round:)
          .monkey_business_level
  end

  def stress_level_congruence
    raw_input.scan(/Test: divisible by (\d+)/)
             .reduce(1) { |result, (prime)| result * prime.to_i }
  end
end
