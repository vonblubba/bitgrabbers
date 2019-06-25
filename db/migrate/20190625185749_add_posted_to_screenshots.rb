class AddPostedToScreenshots < ActiveRecord::Migration[5.2]
  def change
  	add_column :screenshots, :posted, :boolean, default: false
  end
end
