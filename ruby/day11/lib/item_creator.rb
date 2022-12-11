# frozen_string_literal: true

require_relative "item"

class ItemCreator
  def self.generate_inventory(inventory_data, relax_method:)
    ItemParser.new.parse(inventory_data)
              .map { |worry_level| Item.new(worry_level: worry_level.to_i, relax_method:) }
  end

  class ItemParser
    def parse(inventory_data) = inventory_data.delete_prefix("  Starting items: ").split(", ")
  end
end
