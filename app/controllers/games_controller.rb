class GamesController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def index
  end

  def show
    @screenshots = Game.friendly.find(params[:id]).screenshots.published.order("created_at DESC")
  end
end
