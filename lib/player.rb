# frozen_string_literal: true

# get input and store statistics
class Player
  attr_accessor :name, :score, :games

  def initialize(name = 'You')
    self.name = name
    # score and games aren't used for now, but I'll include them for future..
    self.score = 0.0 # W/L
    self.games = [] # all played games(or their represantation)
  end
end
