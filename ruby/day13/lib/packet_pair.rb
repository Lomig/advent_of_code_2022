# frozen_string_literal: true

class PacketPair
  ORDERING_STATUS_ENUM = {
    ordered: -1,
    undecided: 0,
    unordered: 1
  }.freeze

  private attr_reader :left, :right

  def initialize(left:, right:)
    @left = left.content
    @right = right.content
  end

  def ordering_status_value = ORDERING_STATUS_ENUM[ordering_status]

  def ordering_status
    case [left, right]
    in [[]   , []   ] then :undecided
    in [[]   , Array] then :ordered
    in [Array, []   ] then :unordered

    in [[Integer => x, *         ], [Integer => y, *          ]] if x < y then :ordered
    in [[Integer => x, *         ], [Integer => y, *          ]] if x > y then :unordered
    in [[Integer     , *left_tail], [Integer     , *right_tail]]          then new_pair(left_tail, right_tail).ordering_status

    in [[Integer => head, *tail], [Array, *]] then new_pair([[head], *tail], right).ordering_status
    in [[Array, *], [Integer => head, *tail]] then new_pair(left, [[head], *tail]).ordering_status
    
    else head_ordering_status_then_tails_if_undecided
    end
  end

  private

  def head_ordering_status_then_tails_if_undecided
    head_ordering_status = new_pair(left[0], right[0]).ordering_status
    return head_ordering_status unless head_ordering_status == :undecided

    new_pair(left[1..], right[1..]).ordering_status
  end

  def new_pair(left, right)
    PacketPair.new(left: Packet.new(content: left), right: Packet.new(content: right))
  end
end
