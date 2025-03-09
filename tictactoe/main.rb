# frozen_string_literal: true

require_relative 'lib/player'
require_relative 'lib/board'

puts 'Enter username for player 1'
p1 = Player.new(gets.strip)

puts 'Enter username for player 2'
p2 = Player.new(gets.strip)

game = Board.new(p1, p2)

game.play
