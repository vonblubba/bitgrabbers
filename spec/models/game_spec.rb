# == Schema Information
#
# Table name: games
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  year        :integer
#  order       :integer          default(10), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

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
