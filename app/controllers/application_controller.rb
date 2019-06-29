class ApplicationController < ActionController::Base
  def initialize
    @games_items = Game.showcase
    @tags_items = ActsAsTaggableOn::Tag.showcase
    @q = Screenshot.ransack("")
    super
  end

  def after_sign_up_path_for(resource)
    admin_user_path
  end
end
