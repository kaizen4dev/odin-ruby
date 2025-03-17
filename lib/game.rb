# frozen_string_literal: true

# lets you to play
class Game
  include Codable
  include Scorable

  def start
    # get gamemode
    gamemode = ask_gamemode

    # assign/change board and variables depending on gamemode
    prepare(gamemode)

    # play game
    outcome = play(gamemode)

    # show updated board
    show_board

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

  attr_accessor :board, :guess

  # ask and return gamemode
  def ask_gamemode
    system('clear')
    puts 'Choose gamemode: guesser(1), mastermind(2) or two players(3)'
    print 'Enter gamemode number: '
    gamemode = gets.strip.to_i

    ask_gamemode unless gamemode.between?(1, 3)

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
      return unless gamemode == 2

      # 2nd gamemode only
      @possible_codes = all_codes(true)
      self.guess = nil
    end
  end

  # let user play until game over, return outcome
  def play(gamemode)
    # play
    until board.game_over?
      show_board
      self.guess = gamemode == 2 ? bot : ask_code
      outcome = board.make_guess(guess)
    end

    # return result of the game
    outcome
  end

  # shows current board
  def show_board
    system('clear')
    puts 'Guess the code!'
    puts board.board
  end

  # let comptur make guess
  def bot
    # first guess is random
    return generate_code if guess.nil?

    # we can take all possible codes and compare them with our (previous)guess, reducing
    # list of possible codes. It works because by comparing code chosen by mastermind
    # and our guess we will always receive same feedback.
    @possible_codes.select! { |code| new_feedback(code, guess) == board.feedback }

    # choose random code from possibilities
    @possible_codes.sample
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
