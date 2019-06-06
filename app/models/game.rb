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

class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true
  validates :description, presence: true

  has_many :screenshots

  def self.showcase
    Game.order(:order).limit(10)
  end
end
