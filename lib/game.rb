# frozen_string_literal: true

require_relative 'codable'

# lets you to play
class Game
  include Codable

  def initialize(player = Player.new, board = Board.new)
    self.player = player
    self.board = board
  end

  def start
    # play game
    outcome = play

    # print mesasge according to outcome
    if outcome == 'won'
      puts 'Congrats! You guessed the code!'
    else
      puts 'Congrats! You lost the game.'
    end

    # ask for new game
    next_game?
  end

  def self.start
    new.start
  end

  private

  attr_accessor :player, :board

  # let user play until game over, return outcome
  def play
    # play
    until board.game_over?
      system('clear')
      puts "\nGuess the code!"
      puts board.board
      guess = ask_code
      outcome = board.make_guess(guess)
    end

    # Add board to player.games and reset board
    player.games << board
    self.board = Board.new

    outcome
  end

  def next_game?
    # get input
    puts "\nStart new game? (Y)es or (N)o"
    input = gets.downcase[0]

    # start new game or exit depending on input
    if input == 'n'
      exit!
    elsif input == 'y'
      # start new game
      return start
    end

    # ask again if input isn't yes or no
    next_game?
  end

  def ask_name
    puts 'What is your name?'
    gets
  end
end
