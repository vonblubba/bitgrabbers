ActiveAdmin.register ActsAsTaggableOn::Tag, as: "Tag" do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :taggings_count
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

end