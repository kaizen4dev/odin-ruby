# frozen_string_literal: true

# connect four game class
class Game
  EMPTY_SPACE = '⚫'
  BALL1 = '⚽'
  BALL2 = '⚾'

  attr_reader :board

  private

  attr_writer :board

  def initialize
    self.board = Array.new(6) { Array.new(7, EMPTY_SPACE) }
  end

  def show
    puts board.map(&:join) << '1|2|3|4|5|6|7'
  end
end
