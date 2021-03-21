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
#  aspect_ratio     :integer          default("standard")
#  twitter_posted   :boolean          default(FALSE)
#  facebook_posted  :boolean          default(FALSE)
#

class Screenshot < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true
  validates :publication_date, presence: true
  validates :image, presence: true

  belongs_to :game
  belongs_to :user

  mount_uploader :image, ScreenshotUploader

  acts_as_taggable

  enum aspect_ratio: {
         standard:  10,
         ultra_wide: 15
       }

  scope :published,   -> { where(published: true).where('screenshots.publication_date <= ?', DateTime.now) }
  scope :unpublished,   -> { where(published: false).or(Screenshot.where('screenshots.publication_date > ?', DateTime.now)) }
  scope :twitter_unposted,    -> { where(twitter_posted: false).order(:publication_date) }
  scope :facebook_unposted,    -> { where(facebook_posted: false).order(:publication_date) }

  before_save :update_aspect_ratio
  #after_commit :post_to_facebook

  def thumb
    image.thumb.url
  end

  def update_aspect_ratio
    img = MiniMagick::Image.open(Rails.root.join(image.path).to_s)
    ratio = img.width.to_f / img.height.to_f
    self.aspect_ratio = ratio > 1.8 ? :ultra_wide : :standard
  end

  def json_ld
    {
      "@context": "http://schema.org",
      "@type": "ImageObject",
      "author": "vonblubba",
      "contentUrl": [Rails.configuration.global_settings['base_url'], image.original.url].join,
      "datePublished": created_at.strftime("%FT%T"),
      "description": description,
      "name": title,
      "thumbnail": [Rails.configuration.global_settings['base_url'], image.big_thumb.url].join,
      "isBasedOn": {
        "@context": "http://schema.org",
        "@type": "VideoGame",
        "name": self.game.name,
        "url": "#{Rails.configuration.global_settings['base_url']}/games/#{self.game.slug}",
        "description": self.game.description,
        "operatingSystem": "Windows",
        "applicationCategory": "Game"
      }
    }
  end

  def post_to_facebook
    ::FacebookService.post(self.id)
  end

  def self.farthest_publication_date
    return Date.now + 3.days unless Screenshot.all.any?
    Screenshot.order(publication_date: :desc).limit(1).take&.publication_date + 3.days
  end
end
