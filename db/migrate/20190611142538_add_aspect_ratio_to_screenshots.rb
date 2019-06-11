class AddAspectRatioToScreenshots < ActiveRecord::Migration[5.2]
  def change
    add_column :screenshots, :aspect_ratio, :integer, default: 10
  end
end
