# frozen_string_literal: true

# connect four game class
class Game
  attr_reader :board

  private

  attr_writer :board

  def initialize
    self.board = Array.new(6) { Array.new(7, '⚫') }
  end
end
