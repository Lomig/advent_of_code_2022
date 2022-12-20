# frozen_string_literal: true

require_relative "unique_value"

class Decrypter
  private attr_reader :size, :zero
  private attr_accessor :data

  def initialize(input:, decryption_key: 1)
    @size = input.size

    @data = input.map do |x|
      UniqueValue[x * decryption_key].tap { |zero| @zero = zero if x.zero? }
    end
  end

  def decrypt!(repeat: 1)
    mixed_list = mix_data(repeat:)
    index = mixed_list.index(zero)

    [1_000, 2_000, 3_000].sum { |nth| mixed_list[(index + nth) % size].! }
  end

  private

  def mix_data(repeat:) = repeat.times.with_object(data.dup, &mix_data_once)

  def mix_data_once = lambda do |_, mixed_list|
    data.each_with_object(mixed_list) do |value, mixed_list|
      old_indice = mixed_list.index(value)

      mixed_list.delete_at(old_indice)
      mixed_list.insert((old_indice + value.!) % (size - 1), value)
    end
  end
end
