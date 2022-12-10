# frozen_string_literal: true

require_relative "move"

class Paper < Move
  @move = :paper
  
  @value = 2

  @score = {
    rock: :win,
    paper: :draw,
    scissors: :loss
  }
end
