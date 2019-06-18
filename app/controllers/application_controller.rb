class ApplicationController < ActionController::Base
  def initialize
    @games_items = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    @q = Screenshot.ransack("")
    super
  end
end
