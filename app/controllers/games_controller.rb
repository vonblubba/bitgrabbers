class GamesController < ApplicationController
  def index
  end

  def show
    @game = Game.friendly.find(params[:id])
    @meta_description = "All screenshots for videogame #{@game.name} featured on bitgrabbers"
    @page_title = "screenshots for #{@game.name} | Bitgrabbers"
    @screenshots = @game.screenshots.published.order("created_at DESC")
  end
end
