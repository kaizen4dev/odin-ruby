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
    puts 'Choose gamemode: guesser(1), mastermind(2) or two players(3)'
    print 'Enter gamemode number: '
    gamemode = gets.strip.to_i

    ask_gamemode unless gamemode.between?(1, 3)

    # assign/change board and variables depending on gamemode
    prepare(gamemode)

    gamemode
  end

  # prepares board and needed variables depending on gamemode
  def prepare(gamemode)
    # 1st gamemode
    if gamemode == 1
      self.board = Board.new
    else
      # 2nd and 3rd gamemodes
      system('clear')
      puts "Mastermind's choses the code!"
      self.board = Board.new(ask_code)
    end
  end

  # let user play until game over, return outcome
  def play(gamemode)
    # play
    until board.game_over?
      system('clear')
      puts 'Guess the code!'
      puts board.board
      guess = gamemode == 2 ? bot : ask_code
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
