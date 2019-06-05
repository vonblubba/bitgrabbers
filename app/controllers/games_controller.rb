class GamesController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def index
  end

  def show
    @game = Game.friendly.find(params[:id])
    @page_title = @game.name
    @screenshots = @game.screenshots.published.order("created_at DESC")
  end
end
