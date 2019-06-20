class ApplicationController < ActionController::Base
  def initialize
    @games_items = Game.showcase
    @tags_items = ActsAsTaggableOn::Tag.showcase
    @q = Screenshot.ransack("")
    super
  end
end
