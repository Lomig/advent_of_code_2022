# frozen_string_literal: true

class Move
  ROUND_VALUES = {
    loss: 0,
    draw: 3,
    win: 6
  }

  MOVES = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  KNOWN_OPPONENT_SCORES = {
    "X" => :win,
    "Y" => :draw,
    "Z" => :loss
  }

  private attr_accessor :against

  def initialize(against: nil, score: nil)
    @against = against

    forge_score(score) if score
  end

  def opponent = Move.from_know_opponent(opponent: against, against: self.class.move)

  def score = ROUND_VALUES[self.class.score[against]] + self.class.value

  private

  def forge_score(score)
    self.against = self.class.score.key(score)
  end

#########################################################################################################
## CLASS METHODS                                                                                       ##
#########################################################################################################

  class << self
    attr_reader :score, :value, :move

    def complete_move(log:) = create_move(MOVES[log[-1]], :against, MOVES[log[0]])

    def from_known_score(log:) = create_move(MOVES[log[0]], :score, KNOWN_OPPONENT_SCORES[log[-1]]).opponent

    def from_know_opponent(opponent:, against:) = create_move(opponent.to_s, :against, against)

    private

    def create_move(player, type, opponent_or_score)
      Object.const_get(player.capitalize)
            .new(**{type => opponent_or_score})
    end
  end
end

require_relative "rock"
require_relative "paper"
require_relative "scissors"
