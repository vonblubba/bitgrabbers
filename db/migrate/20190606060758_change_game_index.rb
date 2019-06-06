class ChangeGameIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :games, :year
    add_index :games, :year, unique: false
  end
end
