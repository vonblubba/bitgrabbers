class AddInMenuToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :in_menu, :boolean, default: false
    remove_column :games, :order
  end
end
