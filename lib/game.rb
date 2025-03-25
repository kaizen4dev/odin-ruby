# frozen_string_literal: true

# logic of the game
class Game
  private

  attr_accessor :word, :guesses, :tries

  def initialize
    self.word = random_word
    self.guesses = Array.new(word.size, '_')
    self.tries = word.size / 2
  end

  def random_word
    File.readlines('dict.txt').sample.strip
  end
end
