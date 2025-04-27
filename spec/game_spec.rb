# frozen_string_literal: true

require './lib/game'

describe Game do
  describe '#board' do
    it 'created upon initialization' do
      expect(Game.new.board).to eql(Array.new(6, Array.new(7, '⚫')))
    end
  end

  describe '#ball1' do
    it 'is a soccer ball' do
      expect(Game.new.ball1).to eql('⚽')
    end
  end

  describe '#ball2' do
    it 'is a baseball' do
      expect(Game.new.ball2).to eql('⚾')
    end
  end
end
