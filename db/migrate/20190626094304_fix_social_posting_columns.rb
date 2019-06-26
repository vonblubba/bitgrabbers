class FixSocialPostingColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :screenshots, :posted, :twitter_posted
    add_column :screenshots, :facebook_posted, :boolean, default: false
  end
end
