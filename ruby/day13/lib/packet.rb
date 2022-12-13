# frozen_string_literal: true

require_relative "packet_pair"

class Packet
  attr_reader :content

  def initialize(content:)
    @content = content
  end

  def <=>(other) = PacketPair.new(left: self, right: other).ordering_status_value
end
