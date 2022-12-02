# frozen_string_literal: true

require_relative "move"

class Scissors < Move
  @move = :scissors
  
  @value = 3

  @score = {
    rock: :loss,
    paper: :win,
    scissors: :draw
  }
end
