class GamesController < ApplicationController
  def index
  end

  def show
    @game = Game.friendly.find(params[:id])
    @page_title = "screenshots for #{@game.name} | Bitgrabbers"
    @screenshots = @game.screenshots.published.order("created_at DESC")
  end
end
