ActiveAdmin.register Screenshot do
  permit_params :description, :title, :publication_date, :published, :game_id, :image, :user_id, :tag_list

  index do
    selectable_column
    id_column
    column "Thumb" do |thumb|
      image_tag thumb.image.thumb.url
    end
    column :title
    column :publication_date
    toggle_bool_column :published
    column :game
    actions
  end

  filter :publication_date
  filter :published
  filter :game_id

  form(:html => { :multipart => true }) do |f|
    f.object.publication_date = Screenshot.farthest_publication_date
    f.object.user = User.first
    f.inputs do
      user_collection = User.all.map { |user| ["#{user.email}", user.id ]}
      f.input :game
      f.input :title
      f.input :description
      f.input :facebook_posted, :label => "Post update on Bitgrabbers facebook page"
      f.input :tag_list, as: :tags, collection: ActsAsTaggableOn::Tag.all.pluck(:name)
      f.input :publication_date, as: :date_time_picker
      f.input :published
      f.input :image, :as => :file
      f.input :user_id, as: :select, collection: user_collection
    end
    f.actions
  end

end