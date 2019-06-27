class ScreenshotsController < ApplicationController
  def index
    @screenshots = Screenshot.published.order(publication_date: :desc)
    #@screenshots = Screenshot.order(publication_date: :desc).paginate(page: params[:page], per_page: 12)
    @page_title = "Screenshots catalog | Bitgrabbers"
  end

  def show
    @screenshot = Screenshot.published.friendly.find(params[:id])
    @page_title = "#{@screenshot.title} | Screenshot for #{@screenshot.game.name} @ Bitgrabbers"
  end
end