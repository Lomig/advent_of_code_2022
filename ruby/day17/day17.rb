# frozen_string_literal: true

require_relative "../aoc"

require_relative "lib/wind_parser"
require_relative "lib/piece_generator"
require_relative "lib/chamber_state_manager"
require_relative "lib/chamber"

class Day17 < AoC
  input_as :raw, formatter: :chars

  def result1 = simulation(max_piece_count: 2022)

  def result2
    max_piece_count = 1_000_000_000_000
    cycle_description = simulation(max_piece_count:)

    height_from_cycling = height_from_cycling(max_piece_count:, cycle_description:)
    height_from_non_cycling = simulation(max_piece_count: non_cycling_pieces(max_piece_count:, cycle_description:))

    height_from_cycling + height_from_non_cycling
  end

  private

  def simulation(max_piece_count:)
    wind_gusts_count = input.size
    chamber = Chamber.new(spawner: PieceGenerator.new, state_manager: ChamberStateManager.new)

    WindParser.new.parse(input)
              .cycle
              .with_index do |gust_of_wind, wind_index|
                status, result = chamber.tick!(gust_of_wind, wind_index: wind_index % wind_gusts_count, max_piece_count:)
                break result unless status == :ticking
              end
  end

  def height_from_cycling(max_piece_count:, cycle_description:)
    cycles = (max_piece_count - cycle_description[:pieces_count_before]) / cycle_description[:pieces_count_each]
    cycles * cycle_description[:height_gain_each]
  end

  def non_cycling_pieces(max_piece_count:, cycle_description:)
    rest_after_cycles = (max_piece_count - cycle_description[:pieces_count_before]) % cycle_description[:pieces_count_each]
    cycle_description[:pieces_count_before] + rest_after_cycles
  end
end
