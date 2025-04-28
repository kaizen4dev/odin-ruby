# frozen_string_literal: true

require 'io/console'

# connect four game class
class Game
  EMPTY_SPACE = '⚫'
  ROWS = 6
  COLUMNS = 7
  BALL1 = '⚽'
  BALL2 = '⚾'

  def start(show_tutorial: true)
    tutorial if show_tutorial

    winner = play(BALL1)

    puts winner == 'draw' ? 'Game ended in draw!' : "#{winner} won the game!"
    puts 'Press <Enter> to start new game, any other key to exit'
    start(show_tutorial: false) if $stdin.getch == "\r"
  end

  def show
    puts board.dup << '|1|2|3|4|5|6|7|'
  end

  private

  attr_accessor :board

  def initialize
    self.board = Array.new(ROWS) { EMPTY_SPACE * COLUMNS }
  end

  def play(ball)
    # show board
    system('clear')
    puts "#{ball}'s turn, make a move:"
    show

    # get position to insert ball
    column = ask_column
    row = find_row(column)

    # insert ball and pass move to next player
    board[row][column] = ball

    # handle gameover
    return ball if winner? # attention: #winner? isn't implemented yet.
    return 'draw' if draw?

    ball == BALL1 ? play(BALL2) : play(BALL1)
  end

  def find_row(column = ask_column)
    row = ''
    i = 0
    until row.nil? || row[column] == EMPTY_SPACE
      i -= 1
      row = board[i]
    end

    i unless row.nil?
  end

  def draw?
    !board.join.include?(EMPTY_SPACE)
  end

  def winner?
    false
  end

  def ask_column
    puts "Press one of the following:\n
    1-7 - add ball to the column\n
    x - exit game"
    input = $stdin.getch

    exit! if input == 'x'
    ask_column unless input.to_i.between?(1, 7)

    input.to_i - 1
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
