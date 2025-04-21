# frozen_string_literal: true

def knight_moves(start_pos, end_pos)
  queue = [Move.new(start_pos)]

  until queue.any? { |move| move.square == end_pos }
    curr = queue.shift
    possible_moves(curr.square).each { |next_square| queue.push Move.new(next_square, curr) }
  end

  queue.find { |move| move.square == end_pos }.to_a
end

def possible_moves(start_pos)
  directions = [[-1, 2], [-2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1], [1, 2], [2, 1]]
  moves = directions.map { |move| [move[0] + start_pos[0], move[1] + start_pos[1]] }
  moves.select { |move| move[0].between?(0, 7) && move[1].between?(0, 7) }
end

# represents current and previous squares
class Move
  attr_accessor :square, :from

  def initialize(square, from = nil)
    self.square = square
    self.from = from
  end

  def to_a
    move = self
    moves = []

    until move.nil?
      moves.unshift(move.square)
      move = move.from
    end

    moves
  end
end
