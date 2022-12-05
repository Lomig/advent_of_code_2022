# frozen_string_literal: true

class CrateParser
  CRATE = /(    ?|\[\w\] ?)/

  def parse(input) = input.map { |line| parse_line_of_crates(line) }

  private

  def parse_line_of_crates(crates)
    crates.scan(CRATE)
          .map { |crate| crate[0].gsub(/( |\[|\])/, "") }
  end
end
