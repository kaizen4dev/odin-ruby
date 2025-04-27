# frozen_string_literal: true

require './lib/game'

describe Game do
  describe '#board' do
    it 'created upon initialization' do
      expect(Game.new.board).to eql(Array.new(6, Array.new(7, '⚫')))
    end
  end
end
