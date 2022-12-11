# frozen_string_literal: true

class Monkey
  private attr_reader :id, :operation, :worry_checker, :targets
  private attr_accessor :items, :canopy

  def initialize(id:, operation:, worry_checker:, target_if_worry:, target_if_calm:)
    @id = id
    @operation = operation
    @worry_checker = worry_checker

    @targets = {
      worry: target_if_worry,
      calm: target_if_calm
    }.freeze

    @items = []
  end

  def occupy(canopy)
    self.canopy = canopy
    self
  end

  def move!
    items.dup.each { |item| inspect!(item) }
    self
  end

  def throw!(item:, feeling:)
    items.delete(item)
    canopy.fly(item: item, towards: targets[feeling])
    self
  end

  def catch!(item)
    items << item
    self
  end

  def steal_items!(items)
    self.items = items
    self
  end

  private

  def inspect!(item)
    canopy.monkey_business_for_monkey!(monkey_id: id)

    item.increase_worry_with(operation)
        .becomes_boring
        .check_worriedness(checker: worry_checker, monkey: self)
  end
end
