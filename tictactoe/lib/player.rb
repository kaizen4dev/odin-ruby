# frozen_string_literal: true

# responsible for getting input and storing name, score, and used tiles for each player
class Player
  attr_accessor :name, :score, :tiles, :sym, :board

  def initialize(name)
    self.name = name
    self.score = 0
    self.tiles = []
  end

  def move
    # show board..
    board.show

    # get tile number
    print "#{name} moves: "
    tile = gets.strip

    # move and return if successful
    return if board.move(self, tile) == 0

    # otherwise try again
    puts 'Wrong tile, please try again.'
    move
  end
end
