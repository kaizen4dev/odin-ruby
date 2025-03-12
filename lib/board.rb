# frozen_string_literal: true

# responsible for updating and storing board and code for mastermind
class Board
  # some default values
  ALL_COLORS = %i[red blue yellow green magenta cyan].freeze
  BOARD_BLUEPRINT = Array.new(12, '󰽤 󰽤 󰽤 󰽤 ')

  private

  attr_writer :board, :code, :last_feedback

  def initialize(code = generate_code)
    new_board
    self.code = code
  end

  # generates random code
  def generate_code
    code = []
    4.times do
      code << '󰽢'.colorize(ALL_COLORS.sample)
    end
    code.join(' ')
  end

  # reset/create board
  def new_board
    self.board = BOARD_BLUEPRINT.dup
  end

  # compare guess and give feedback with colored "!"
  def feedback(guess)
    # convert code and guess to arrays
    code = self.code.split(' ')
    guess = guess.split(' ')

    feedback = []

    # add red "!"s to feedback and change used spheres to nil
    (0..3).each do |i|
      next unless code[i] == guess[i]

      feedback.push('!'.red)
      code[i] = guess[i] = nil
    end

    # count rest of spheres
    count = { guess: Hash.new(0), code: Hash.new(0) }
    guess.each do |value|
      count[:guess][value] += 1 unless value.nil?
    end
    code.each do |value|
      count[:code][value] += 1 unless value.nil?
    end

    # reduce guess to only include those spheres that are in code
    count[:guess].select! { |key, _value| count[:code].keys.include?(key) }

    # push white "!"s to feedback
    # ===========================================
    #
    # for each sphere in guess
    #   compare how many times sphere appeared in guess and code
    #   if guess has more spheres than code
    #     (spheres in code).times push "!" to feedback
    #   otherwise
    #     do it (spheres in guess).times
    #
    # ===========================================
    count[:guess].each_key do |key|
      if count[:guess][key] < count[:code][key]
        count[:guess][key].times { feedback.push('!') }
      else
        count[:code][key].times { feedback.push('!') }
      end
    end

    # finally record and return our feedback
    self.last_feedback = feedback.join('')
    feedback.join('')
  end

  public

  attr_reader :board, :code, :last_feedback

  # add guess to current board
  def make_guess(guess)
    i = board.index('󰽤 󰽤 󰽤 󰽤 ')
    board[i] = "#{guess} | #{feedback(guess)}" unless i.nil?
  end

  def colors
    ALL_COLORS
  end
end
