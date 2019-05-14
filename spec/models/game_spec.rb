require 'spec_helper'

describe Game do
  describe 'with no description' do
      game = Game.new
      game.name = 'fake_game'
      game.valid?
      it 'does not pass validation' do
        expect(game).to_not be_valid
      end
  end

  describe 'with no name' do
    game = Game.new
    game.description = 'fake game'
    game.valid?
    it 'does not pass validation' do
      expect(game).to_not be_valid
    end
  end
end
