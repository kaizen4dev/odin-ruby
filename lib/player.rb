# frozen_string_literal: true

# get input and store statistics
class Player
  attr_accessor :name, :score, :games

  def initialize(name = 'You')
    self.name = name
    # score and games aren't used for now, but I'll include them for future..
    self.score = 0.0 # W/L
    self.games = [] # all played games(or their represantation)
  end

  def make_guess
    puts "Numbers represent colors: #{'1'.red}, #{'2'.blue}, #{'3'.yellow}, #{'4'.green}, #{'5'.magenta}, #{'6'.cyan}"
    puts 'Enter your guess(4 digits):'
    code = gets.strip

    # ensure code is valid
    until valid_code?(code)
      puts "\nInvalid code! Try again"
      code = gets.strip
    end

    # convert code to spheres and return it
    convert_code(code)
  end

  private

  def convert_code(number)
    # get all possible colors
    colors = Board.colors

    # split number to array
    numbers = number.split('')

    # declare code array
    code = []

    # convert
    numbers.each do |n|
      code << '󰽢'.colorize(colors[n.to_i - 1])
    end

    code.join(' ')
  end

  def valid_code?(code)
    # check size and type
    return false unless code.is_a?(String) &&
                        code.size == code.to_i.to_s.size &&
                        code.size == 4

    # convert to array of numbers
    nums = code.split('').map(&:to_i)

    # check if nums are in colors scope, return result
    nums.all? { |num| num.between?(1, 6) }
  end
end
