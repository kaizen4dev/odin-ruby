# frozen_string_literal: true

# provide feedback for mastermind
module Scorable
  # return feedback by comparing provided guess and code
  def new_feedback(guess, code)
    # assign feedback to be an array
    self.feedback = []

    # convert code and guess to arrays
    code = code.split(' ')
    guess = guess.split(' ')

    # add red "!" - spheres guessed correctly
    red_feedback(guess, code)

    # add white "!" - spheres from guess appeared in code, but in wrong place
    white_feedback(guess, code)

    # return feedback as a string
    feedback.join('')
  end

  private

  attr_accessor :feedback

  # add red "!"s to feedback and delete used sphares from guess and code arrays
  # provided code and guess must be strings
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
  # provided code and guess must be strings
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
end
