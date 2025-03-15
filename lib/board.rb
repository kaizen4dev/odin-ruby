# frozen_string_literal: true

require_relative 'codable'

# responsible for updating and storing board and code for mastermind
class Board
  include Codable

  # some default values
  ALL_COLORS = %i[red blue yellow green magenta cyan].freeze
  BOARD_BLUEPRINT = Array.new(12, '󰽤 󰽤 󰽤 󰽤 ')

  private

  attr_writer :board, :code, :feedback

  def initialize(code = generate_code)
    new_board
    self.code = code
  end

  # reset/create board
  def new_board
    self.board = BOARD_BLUEPRINT.dup
  end

  # update feedback accourding to guess
  def new_feedback(guess)
    # clear previous feedback
    self.feedback = []

    # convert code and guess to arrays
    code = self.code.split(' ')
    guess = guess.split(' ')

    # add red "!" - spheres guessed correctly
    red_feedback(guess, code)

    # add white "!" - spheres from guess appeared in code, but in wrong place
    white_feedback(guess, code)

    # convert feedback from array to string
    self.feedback = feedback.join('')
  end

  # add red "!"s to feedback and delete used sphares from guess and code arrays
  def red_feedback(guess, code)
    (0..3).each do |i|
      next unless code[i] == guess[i]

      feedback.push('!'.red)
      code[i] = guess[i] = nil
    end

    # delete nils
    code.compact!
    guess.compact!

    feedback
  end

  # adds white "!"s to feedback array
  def white_feedback(guess, code)
    # count rest of spheres
    count = { guess: Hash.new(0), code: Hash.new(0) }
    guess.each { |value| count[:guess][value] += 1 }
    code.each { |value| count[:code][value] += 1 }

    # reduce guess to only include those spheres that are in code
    count[:guess].select! { |key, _value| count[:code].keys.include?(key) }

    # push white "!"s to feedback
    # ===========================================
    #
    # for each sphere in guess
    #   compare how many times sphere appeared in guess and code
    #
    #   if guess has more spheres than code
    #     n = amount of speres in code
    #   otherwise
    #     n = amount of speres in guess
    #
    #   n.times push "!" to feedback
    #
    # ===========================================
    count[:guess].each_key do |key|
      n = count[:guess][key] < count[:code][key] ? count[:guess][key] : count[:code][key]
      n.times { feedback.push('!') }
    end
  end

  public

  attr_reader :board, :code, :feedback

  # add guess to current board and return status of the game
  def make_guess(guess)
    # get index of first "empty" row
    i = board.index('󰽤 󰽤 󰽤 󰽤 ')

    # update feedback
    new_feedback(guess)

    # fill that row with guess and feedback
    board[i] = "#{guess} | #{feedback}" unless i.nil?

    # return status
    if feedback == "\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m"
      'won'
    elsif i.nil?
      'lost'
    else
      'ongoing'
    end
  end

  def game_over?
    board.index('󰽤 󰽤 󰽤 󰽤 ').nil? || feedback == "\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m"
  end

  def self.colors
    ALL_COLORS
  end
end
