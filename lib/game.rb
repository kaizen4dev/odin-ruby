# frozen_string_literal: true

# lets you to play
class Game
  include Codable

  def start
    # gamemode
    gamemode = ask_gamemode

    # play game
    outcome = play(gamemode)

    # print mesasge according to outcome
    if outcome == 'won'
      puts 'Guesser won the game!'
    else
      puts 'Mastermind won the game!'
    end

    # ask for new game
    next_game?
  end

  def self.start
    new.start
  end

  private

  attr_accessor :board

  # ask and return gamemode
  def ask_gamemode
    system('clear')
    puts 'Choose gamemode: guesser(1) or mastermind(2)'
    print 'Enter gamemode number: '
    gamemode = gets.strip.to_i

    ask_gamemode unless gamemode.between?(1, 2)

    # assign/change board depending on gamemode
    self.board = gamemode == 2 ? Board.new(ask_code) : Board.new

    gamemode
  end

  # let user play until game over, return outcome
  def play(gamemode)
    # play
    until board.game_over?
      system('clear')
      puts 'Guess the code!'
      puts board.board
      guess = gamemode == 1 ? ask_code : bot
      outcome = board.make_guess(guess)
    end

    outcome
  end

  # let comptur make guess
  def bot
    generate_code
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
end
