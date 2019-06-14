class ScreenshotsController < ApplicationController
  def index
    @screenshots = Screenshot.order(publication_date: :desc).paginate(page: params[:page], per_page: 12)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @screenshot = Screenshot.friendly.find(params[:id])
    @page_title = @screenshot.title
  end
end