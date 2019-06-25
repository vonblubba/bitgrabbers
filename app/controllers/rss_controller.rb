class RssController < ApplicationController
  def index
    @screenshots = Screenshot.published.order(publication_date: :desc)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
