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

  def find_row(column = ask_column)
    row = []
    i = 0
    until row[column] == EMPTY_SPACE || row.nil?
      i -= 1
      row = board[i]
    end

    i unless row.nil?
  end

  def draw?
    !board.map(&:join).join.include?(EMPTY_SPACE)
  end

  def ask_column
    puts "Press one of the following:\n
    1-7 - add ball to the column\n
    x - exit game"
    input = $stdin.getch

    exit! if input == 'x'
    ask_column unless input.to_i.between?(1, 7)

    input.to_i
  end

  def tutorial
    puts "Welcome to the connect 4!\n
      Here are 4 simple rules:\n
      1. Go and fetch your friend, if you have one.. Anyway, game requires 2 players.\n
      2. You and your friend will be playing as soccer ball and baseball. Soccer ball is always first to move.\n
      3. Each turn you need to place 1 ball into the column, then pass pc to your friend, so he makes move too.\n
      4. To win connect 4 balls into the line. Be it horizontally, vertically or even diagonally."
    puts 'Press <Enter> to continue' until $stdin.getch == "\r"
  end
end
