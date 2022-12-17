# frozen_string_literal: true

class ChamberStateManager
  HIGH_PIECE_COUNT_TO_GET_REAL_CYCLES = 2022

  private attr_reader :states

  def initialize
    @states = {}
  end

  def add_or_find_state(wind_index:, piece_index:, skyline:, piece_count:, height:)
    return [:skipped] unless height > HIGH_PIECE_COUNT_TO_GET_REAL_CYCLES

    state_key = [wind_index, piece_index, skyline]
    state = states[state_key]

    return [:exists, cycle_status(state:, piece_count:, height:)] if state

    [:created, states[state_key] = [piece_count, height]]
  end

  private

  def cycle_status(state:, piece_count:, height:)
    {
      pieces_count_before: state[0],
      pieces_count_each: piece_count - state[0],
      height_gain_each: height - state[1]
    }
  end
end
