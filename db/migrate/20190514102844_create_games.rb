class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.text :description, null: false
      t.string :name, null: false
      t.integer :year
      t.integer :order, null: false, default: 10
      t.timestamps
    end

    add_index :games, :name, unique: true
    add_index :games, :year, unique: true
  end
end
