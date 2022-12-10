# frozen_string_literal: true

require_relative "move"

class Rock < Move
  @move = :rock
  
  @value = 1

  @score = {
    rock: :draw,
    paper: :loss,
    scissors: :win
  }
end
