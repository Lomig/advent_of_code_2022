# frozen_string_literal: true

class LambdaParser
  MONKEY_LAMBDAS = /(?<name>.*?): (?<lambda>.*)/
  MONKEY_NODES = /(?<name>.*?): ((?<value>-?\d+)|(?<left>.*?) (?<operator>.) (?<right>.*))/

  OPERATIONS = {
    "+" => { operation: ->(x, y) { x + y }, l_reverse: ->(sum, right) { sum - right }, r_reverse: lambda { |sum, left| sum - left } },
    "-" => { operation: ->(x, y) { x - y }, l_reverse: ->(dif, right) { dif + right }, r_reverse: lambda { |dif, left| left - dif } },
    "*" => { operation: ->(x, y) { x * y }, l_reverse: ->(mul, right) { mul / right }, r_reverse: lambda { |mul, left| mul / left } },
    "/" => { operation: ->(x, y) { x / y }, l_reverse: ->(div, right) { div * right }, r_reverse: lambda { |div, left| left / div } }
  }.freeze

  private attr_reader :tree, :node_class

  def initialize(tree: nil, node_class: nil)
    @tree = tree
    @node_class = node_class
  end

  def parse_as_lambdas(input)
    input.each_with_object({}) do |monkey, lambdas|
      match_data = monkey.match(MONKEY_LAMBDAS)

      lambdas[match_data[:name].to_sym] = match_data[:lambda]
    end
  end

  def parse_as_binary_tree(input)
    input.each { |node| parse_monkey_node(node.match(MONKEY_NODES)) }

    tree.root = tree.nodes[:root]
  end

  private

  def parse_monkey_node(node_data)
    node, left, right = %i[name left right].map { |n| find_or_create(name: node_data[n]&.to_sym) }

    return node.value = node_data[:value].to_i unless left

    node.operations = node.name == :root ? ->(x, y) { x == y } : OPERATIONS[node_data[:operator]]
    node.left = left
    node.right = right
    node
  end

  def find_or_create(name:)
    return unless name

    tree.nodes[name] = tree.nodes.fetch(name, node_class.new(name:))
  end
end
