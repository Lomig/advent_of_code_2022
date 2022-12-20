# frozen_string_literal: true

require_relative "../aoc"

class Day20 < AoC
  input_as :array, formatter: :to_i

  def result1
    Decrypter.new(input:)
             .decrypt!
  end

  def result2
    Decrypter.new(input:, decryption_key: 811_589_153)
             .decrypt!(repeat: 10)
  end
end
