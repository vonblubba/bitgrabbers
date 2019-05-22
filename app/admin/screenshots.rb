ActiveAdmin.register Screenshot do
  permit_params :description, :title, :publication_date, :published, :game_id, :image, :user_id, :tag_list

  index do
    selectable_column
    id_column
    column :title
    column :publication_date
    column :published
    column :game
    actions
  end

  filter :publication_date
  filter :published
  filter :game_id

  form(:html => { :multipart => true }) do |f|
    f.inputs do
      user_collection = User.all.map { |user| ["#{user.email}", user.id ]}
      f.input :game
      f.input :title
      f.input :description
      f.input :tag_list
      f.input :publication_date
      f.input :published
      f.input :image, :as => :file
      f.input :user_id, as: :select, collection: user_collection
    end
    f.actions
  end

end