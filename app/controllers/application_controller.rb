class ApplicationController < ActionController::Base
  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    @q = Screenshot.ransack("")
    super
  end
end
