class PagesController < ApplicationController
  def index
    @screenshots = Screenshot.order(publication_date: :desc).limit(7)
  end

  def about
    @page_title = 'About us'
    @screenshots_count = Screenshot.published.count
    @games_count = Game.all.count
  end

  def submit
    @page_title = 'Submit your shots'
  end

  def search
    @q = Screenshot.ransack(params[:q])
    @screenshots = @q.result(distinct: true)
  end

  def robots
    render file: Rails.root.join("config/robots.#{Rails.env}.txt"), :layout => false, :content_type => "text/plain"
  end

  private
end
