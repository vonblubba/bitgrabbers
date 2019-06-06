ActiveAdmin.register Submission do
  permit_params :email, :image, :game

  index do
    selectable_column
    id_column
    column "Thumb" do |thumb|
      image_tag thumb.image.thumb.url
    end
    column :email
    column :game
    actions
  end

  show do
    attributes_table do
      row :image do |ad|
        image_tag ad.image.url
      end
      row :game
      row :email
      row('Download') { |b| link_to 'Download', b.image_url, download: "Screenshot_#{File.basename(b.image.path)}_image" }
    end
  end

  filter :game
  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :game
    end
    f.actions
  end

end