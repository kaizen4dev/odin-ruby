# frozen_string_literal: true

# responsible of general flow of the game
class Board
  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze
  BOARD_BLUEPRINT = "\n1|2|3\n4|5|6\n7|8|9"

  attr_accessor :players, :board

  def initialize(p1 = Player.new('p1'), p2 = Player.new('p2'))
    self.players = [p1, p2]
    self.board = BOARD_BLUEPRINT

    p1.board = self
    p2.board = self

    players[0].sym = 'x'
    players[1].sym = 'o'
  end

  # start the game
  def play
    # play till game is over
    loop { players.each(&:move) }
  end

  # move by passing player(object) and tile
  def move(player, tile)
    # get index of a tile, if not found return nil
    i = board.index(tile)
    return nil unless i

    # register move
    player.tiles.push(tile.to_i)

    board = self.board.split('')
    board[i] = player.sym
    self.board = board.join('')

    # end the game if one of conditions met

    # someone got a win
    WINS.each do |win|
      game_over(player) if win & player.tiles == win
    end

    # noone won and no tiles left, i.e. draw
    game_over(1) unless board.any?(/\d/)

    0 # return success
  end

  # end the game
  # use player object(for win) or 1(for draw) as argument
  def game_over(player)
    # print result of the game
    if player != 1
      puts "\nGame over! #{player.name} won the game!"
      player.score += 1
    else
      puts "\nIt's a draw!"
    end

    # print new score
    puts "#{players[0].name}: #{players[0].score}\n#{players[1].name}: #{players[1].score}"

    # prepare for next round
    reset

    # ask about next game
    next_game?
  end

  # reset board and tiles to defaults
  def reset
    self.board = BOARD_BLUEPRINT
    players[0].tiles = []
    players[1].tiles = []
  end

  # ask if users want to play more
  def next_game?
    # get input
    puts "\nStart new game? (Y)es or (N)o"
    input = gets.downcase[0]

    # start new game or exit depending on input
    if input == 'n'
      exit!
    elsif input == 'y'
      # switch player order, so everyone has a chance to move first
      switch_players
      # start new game
      return play
    end

    # ask again if input isn't yes or no
    next_game?
  end

  # switch player order
  def switch_players
    players.reverse!
    players[0].sym, players[1].sym = players[1].sym, players[0].sym
    puts 'Switching sides!'
  end

  # print current board
  def show
    puts board
  end
end
