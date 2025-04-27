# frozen_string_literal: true

# connect four game class
class Game
  EMPTY_SPACE = '⚫'
  BALL1 = '⚽'
  BALL2 = '⚾'

  def show
    puts board.map(&:join) << '1|2|3|4|5|6|7'
  end

  private

  attr_accessor :board

  def initialize
    self.board = Array.new(6) { Array.new(7, EMPTY_SPACE) }
  end
end
