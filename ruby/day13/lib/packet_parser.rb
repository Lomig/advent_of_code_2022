# frozen_string_literal: true

require_relative "packet"
require_relative "packet_pair"

class PacketParser
  def parse_pairs(input)
    input.split("\n\n").map do |pair|
      pair.split("\n")
          .then { |left, right| PacketPair.new(left: packet(left), right: packet(right)) }
    end
  end

  def parse_singletons(input)
    input.split("\n")
         .filter_map { |singleton| packet(singleton) unless singleton.empty? }
  end

  private

  def packet(content) = Packet.new(content: eval(content)) 
end
