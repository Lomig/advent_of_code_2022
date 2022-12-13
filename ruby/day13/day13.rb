# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/packet_parser"
require_relative "lib/packet"

class Day13 < AoC
  DIVIDERS = [[[2]], [[6]]]

  input_as :raw

  def result1
    PacketParser.new.parse_pairs(input)
                .each_with_index
                .sum do |pair, index|
                  next 0 if pair.ordering_status == :unordered

                  index + 1
                end
  end

  def result2
    PacketParser.new.parse_singletons(input)
                .then(&add_dividers)
                .sort
                .map(&:content)
                .then(&decoder_key)
  end

  private

  def add_dividers = lambda { |packets| packets << Packet.new(content: DIVIDERS[0]) << Packet.new(content: DIVIDERS[1]) }

  def decoder_key = lambda { |packets| (packets.index(DIVIDERS[0]) + 1) * (packets.index(DIVIDERS[1]) + 1) }
end
