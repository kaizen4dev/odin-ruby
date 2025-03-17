# frozen_string_literal: true

require_relative 'codable'
require_relative 'scorable'

# responsible for updating and storing board and code for mastermind
class Board
  include Codable
  include Scorable

  # some default values
  ALL_COLORS = %i[red blue yellow green magenta cyan].freeze
  BOARD_BLUEPRINT = Array.new(12, '󰽤 󰽤 󰽤 󰽤 ')
  WINNING_SCORE = "\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m\e[0;31;49m!\e[0m"

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

  public

  attr_reader :board, :code, :feedback

  # add guess to current board and return status of the game
  def make_guess(guess)
    # get index of first "empty" row
    i = board.index('󰽤 󰽤 󰽤 󰽤 ')

    # update feedback
    self.feedback = new_feedback(guess, code)

    # fill that row with guess and feedback
    board[i] = "#{guess} | #{feedback}" unless i.nil?

    # return status
    if feedback == WINNING_SCORE
      'won'
    elsif i.nil?
      'lost'
    else
      'ongoing'
    end
  end

  def game_over?
    board.index('󰽤 󰽤 󰽤 󰽤 ').nil? || feedback == WINNING_SCORE
  end

  def self.colors
    ALL_COLORS
  end
end
