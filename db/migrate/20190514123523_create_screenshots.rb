class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.integer    :game_id, null: false
      t.text       :description
      t.integer    :user_id, null: false
      t.string     :title, null: false
      t.boolean    :published, null: false, default: false
      t.datetime   :publication_date

      t.timestamps
    end

    add_index :screenshots, :game_id
    add_index :screenshots, :publication_date
  end
end
