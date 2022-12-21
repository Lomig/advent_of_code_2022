# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/lambda_parser"
require_relative "lib/monkey_tree"
require_relative "lib/node"

class Day21 < AoC
  def result1
    @lambdas = LambdaParser.new.parse_as_lambdas(input)

    root
  end

  def result2
    monkey_tree = MonkeyTree.new.tap { |tree| LambdaParser.new(tree:, node_class: Node).parse_as_binary_tree(input) }

    monkey_tree.mark_unknown_nodes!
               .then { |(unknown_branch, value_to_reach)| unknown_branch.tap { |node| node.value = value_to_reach } }
               .then(&:propagate_value!)

    monkey_tree.human_input
  end

  private

  def method_missing(method_name, *args, &block) = @lambdas[method_name] ? eval(@lambdas[method_name]) : super
end
