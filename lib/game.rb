# frozen_string_literal: true

# logic of the game
class Game
  def start
    # play game
    play while ongoing?

    # print result after game finished
    result = word == guesses.join('') ? 'won' : 'lost'

    puts "Answer: #{word}"
    puts "Congrats, you #{result} the game!"
  end

  def self.start
    new.start
  end

  private

  attr_accessor :word, :guesses, :tries

  def initialize
    self.word = random_word
    self.guesses = Array.new(word.size, '_')
    self.tries = word.size / 2
  end

  def random_word
    File.readlines('dict.txt').sample.strip
  end

  def play
    system('clear')
    puts "Word: #{guesses.join}"
    puts "Tries left: #{tries}\n"

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

    return self.tries -= 1 unless word.include?(guess)

    word.chars.each_with_index do |char, i|
      guesses[i] = char if char == guess
    end
  end

  def ongoing?
    return false if tries.zero? || word == guesses.join('')

    true
  end

  def save
    puts "Game saving isn't implemented yet, so your game is lost :>"
    exit!
  end
end
