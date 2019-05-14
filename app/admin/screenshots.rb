ActiveAdmin.register Screenshot do
  permit_params :description, :title, :publication_date, :published, :game_id, :image, :user_id

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
      f.input :game_id
      f.input :title
      f.input :description
      f.input :publication_date
      f.input :published
      f.input :image, :as => :file
      f.input :user_id
    end
    f.actions
  end

end