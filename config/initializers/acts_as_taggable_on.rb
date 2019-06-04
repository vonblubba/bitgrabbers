ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def self.showcase
    ActsAsTaggableOn::Tag.order(:created_at).limit(10)
  end
end