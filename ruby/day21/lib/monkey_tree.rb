# frozen_string_literal: true

class MonkeyTree
  attr_reader :nodes
  attr_writer :root

  private attr_reader :root

  def initialize(root: nil)
    @root = root
    @nodes = {}
  end

  delegate :left, to: :root

  delegate :right, to: :root

  def human_input = nodes[:humn].value

  def mark_unknown_nodes!
    nodes[:humn].unknown!

    root.compute_values!

    [
      left.unknown? ? left : right,
      (left.unknown? ? right : left).value
    ]
  end
end
