# frozen_string_literal: true

require_relative "monkey"
require_relative "item_creator"

class MonkeyCreator
  def self.generate_family(input, relax_method:)
    input.each_slice(7).map do |monkey_data|
      Monkey.new(**MonkeyParser.new.parse(monkey_data))
            .steal_items!(ItemCreator.generate_inventory(monkey_data[1], relax_method:))
    end
  end

  class MonkeyParser
    def parse(monkey_data)
      {
        id: monkey_data[0][/\d+/].to_i,
        operation:  ->(old) { eval(monkey_data[2].split(" = ").last) },
        worry_checker: ->(worry_level) { worry_level % monkey_data[3][/\d+/].to_i == 0 },
        target_if_worry: monkey_data[4][/\d+/].to_i,
        target_if_calm: monkey_data[5][/\d+/].to_i
      }
    end
  end
end
