# == Schema Information
#
# Table name: games
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  in_menu     :boolean          default(FALSE)
#

class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true
  validates :description, presence: true

  has_many :screenshots

  def self.showcase
    Game.where(in_menu: true).order(:name).limit(10)
  end
end
