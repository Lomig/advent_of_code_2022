# frozen_string_literal: true

class Item
  private attr_reader :relax_method
  private attr_accessor :worry_level

  def initialize(worry_level:, relax_method:)
    @worry_level = worry_level
    @relax_method = relax_method
  end

  def increase_worry_with(operation)
    self.worry_level = operation.call(worry_level)
    self
  end

  def becomes_boring
    self.worry_level = relax_method.call(worry_level)
    self
  end

  def check_worriedness(checker:, monkey:)
    monkey.throw!(
      item: self,
      feeling: worriedness_level(checker)
    )
    self
  end

  private

  def worriedness_level(stress_checker)
    return :worry if stress_checker.call(worry_level)

    :calm
  end
end
