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
#  image            :string
#  slug             :string
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

  enum aspect_ratio: {
         standard:  10,
         ultra_wide: 15
       }

  scope :published,   -> { where(published: true).where('screenshots.created_at <= ?', DateTime.now) }

  before_save :update_aspect_ratio

  def thumb
    image.thumb.url
  end

  def update_aspect_ratio
    img = MiniMagick::Image.open(Rails.root.join(image.path).to_s)
    ratio = img.width.to_f / img.height.to_f
    self.aspect_ratio = ratio > 1.8 ? :ultra_wide : :standard
  end
end
