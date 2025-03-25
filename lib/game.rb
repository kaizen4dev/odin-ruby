# frozen_string_literal: true

require 'json'

# logic of the game
class Game
  def start
    # play game
    play while ongoing?

    # print result after game finished
    result = game['word'] == game['guesses'].join('') ? 'won' : 'lost'

    puts "Answer: #{game['word']}"
    puts "Congrats, you #{result} the game!"
  end

  def self.start
    new.start
  end

  private

  attr_accessor :game

  def initialize
    puts '(1) Start new game'
    puts '(2) Load game'

    number = 0
    until number.between?(1, 2)
      print 'Enter number: '
      number = gets.strip.to_i
    end

    prepare(number)
  end

  def prepare(number)
    self.game = {}

    if number == 1
      game['word'] = random_word
      game['guesses'] = Array.new(game['word'].size, '_')
      game['tries'] = game['word'].size / 2
    else
      load
    end
  end

  def load
    puts 'Tip: enter empty line to abort'
    savename = ask_savename

    until save_exist?(savename) || savename.empty?
      puts "Save doesn't exist"
      savename = ask_savename
    end

    exit! if savename.empty?

    self.game = read_saves[savename]
  end

  def random_word
    File.readlines('dict.txt').sample.strip
  end

  def play
    system('clear')
    puts "Word: #{game['guesses'].join}"
    puts "Tries left: #{game['tries']}\n"

    register_guess(ask_guess)
  end

  def ask_guess
    puts 'Tip: you can save game by writing "save" as your guess.'
    print 'Enter your guess: '
    guess = gets.strip

    until guess.size == 1 || guess == 'save'
      puts "\nGuess must contain only 1 letter"
      print 'Try again: '
      guess = gets.strip
    end

    guess
  end

  def register_guess(guess)
    guess = guess.downcase

    return save if guess == 'save'

    return game['tries'] -= 1 unless game['word'].include?(guess)

    game['word'].chars.each_with_index do |char, i|
      game['guesses'][i] = char if char == guess
    end
  end

  def ongoing?
    return false if game['tries'].zero? || game['word'] == game['guesses'].join('')

    true
  end

  def save
    # create saves dir
    Dir.mkdir('saves') unless Dir.exist?('saves')

    # ask for savename
    savename = ask_savename

    # ask again if save with such name already exist
    while save_exist?(savename)
      puts 'Save with such name already exist. Do you wish to overwrite it?'
      break if gets[0] == 'y'

      savename = ask_savename
    end

    # create savefile
    new_save(savename)

    # exit game
    exit!
  end

  def new_save(savename)
    saves = File.exist?('saves.json') ? read_saves : {}
    saves[savename] = game
    json = JSON.generate(saves)

    file = File.open('saves.json', 'w')
    file.puts(json)
    file.close
  end

  def ask_savename
    print 'Enter save name: '
    gets.strip
  end

  def save_exist?(savename)
    return false unless File.exist?('saves.json')

    read_saves.include?(savename)
  end

  def read_saves
    JSON.parse(File.read('saves.json'))
  end
end
