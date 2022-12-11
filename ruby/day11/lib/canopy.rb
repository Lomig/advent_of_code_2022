# frozen_string_literal: true

class Canopy
  private attr_reader :monkeys, :monkey_business

  def initialize(monkeys:)
    @monkeys = monkeys.freeze
    @monkey_business = []

    populate_canopy!
  end

  def play!(round: 1)
    round.times { |a| monkeys.each(&:move!) }
    self
  end

  def fly(item:, towards:)
    monkeys[towards].catch!(item)
    self
  end

  def monkey_business_for_monkey!(monkey_id:)
    monkey_business[monkey_id] = monkey_business[monkey_id].to_i + 1
    self
  end

  def monkey_business_level = monkey_business.max(2).reduce(&:*)

  private

  def populate_canopy! = monkeys.each { |monkey| monkey.occupy(self) }
end
