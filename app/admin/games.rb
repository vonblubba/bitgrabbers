ActiveAdmin.register Game do
  permit_params :name, :description, :order, :year

  index do
    selectable_column
    id_column
    column :name
    column :year
    column :order
    actions
  end

  filter :name
  filter :year

  form do |f|
    f.inputs do
      f.input :name
      f.input :year
      f.input :order
      f.input :description
    end
    f.actions
  end

end