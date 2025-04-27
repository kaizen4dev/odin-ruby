# frozen_string_literal: true

# connect four game class
class Game
  attr_reader :board, :ball1, :ball2

  private

  attr_writer :board

  def initialize
    self.board = Array.new(6) { Array.new(7, '⚫') }
    @ball1 = '⚽'
    @ball2 = '⚾'
  end

  def show
    puts board.map(&:join) << '1|2|3|4|5|6|7'
  end
end
