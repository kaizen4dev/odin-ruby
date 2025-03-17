# frozen_string_literal: true

# helper methods related to mastermind code
module Codable
  # generates random code
  def generate_code
    code = []
    4.times do
      code << '󰽢'.colorize(Board.colors.sample)
    end
    code.join(' ')
  end

  # ask user to input code
  def ask_code
    puts "Numbers represent colors: #{'1'.red}, #{'2'.blue}, #{'3'.yellow}, #{'4'.green}, #{'5'.magenta}, #{'6'.cyan}"
    puts 'Enter your code(4 digits):'
    code = gets.strip

    # ensure code is valid
    until valid_code?(code)
      puts "\nInvalid code! Try again"
      code = gets.strip
    end

    # convert code to spheres and return it
    convert_code(code)
  end

  # returns array with all posible codes(as numbers!)
  def all_codes
    (1111..6666).select { |i| i.digits.all? { |d| d.between?(1, 6) } }
  end

  private

  # checks if code(as a number!) is valid
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

  # converts code from number to colorized spheres
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
end
