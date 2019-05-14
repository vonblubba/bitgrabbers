class AddImageToScreenshots < ActiveRecord::Migration[5.2]
  def change
    add_column :screenshots, :image, :string
  end
end
