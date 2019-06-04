# == Schema Information
#
# Table name: screenshots
#
#  id               :bigint           not null, primary key
#  game_id          :integer          not null
#  description      :text
#  user_id          :integer          not null
#  title            :string           not null
#  published        :boolean          default(FALSE), not null
#  publication_date :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Screenshot < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true
  validates :publication_date, presence: true

  belongs_to :game
  belongs_to :user

  mount_uploader :image, ScreenshotUploader

  acts_as_taggable

  def thumb
    image.thumb.url
  end
end
