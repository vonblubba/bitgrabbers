class AddSlugToScreenshots < ActiveRecord::Migration[5.2]
  def change
    add_column :screenshots, :slug, :string
    add_index :screenshots, :slug, unique: true
  end
end
