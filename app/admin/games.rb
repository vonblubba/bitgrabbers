ActiveAdmin.register Game do
  permit_params :name, :description, :in_menu, :year

  index do
    selectable_column
    id_column
    column :name
    column :year
    toggle_bool_column :in_menu
    actions
  end

  filter :name
  filter :year
  filter :in_menu

  form do |f|
    f.inputs do
      f.input :name
      f.input :year
      f.input :description
      f.input :in_menu
    end
    f.actions
  end

end
