class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string     :image, null: false
      t.string     :email
      t.string     :game

      t.timestamps
    end
  end
end
