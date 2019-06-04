ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def self.showcase
    ActsAsTaggableOn::Tag.order(taggings_count: :desc).limit(10)
  end
end