class PagesController < ApplicationController
  def index
    @screenshots = Screenshot.published.order(publication_date: :desc).limit(7)
  end

  def about
    @meta_description = "About the bitgrabbers. We are gamers, our mission is to preserve the best gaming moments."
    @page_title = 'About us | Bitgrabbers'
    @screenshots_count = Screenshot.published.count
    @games_count = Game.all.count
  end

  def submit
    @meta_description = "Sendo your best shots to Bitgrabbers. They may be featured on the website."
    @page_title = "Submit your best screenshots | Bitgrabbers"
  end

  def search
    @meta_description = "Screenshot serach result"
    @q = Screenshot.ransack(params[:q])
    @screenshots = @q.result(distinct: true)
  end

  def robots
    render file: Rails.root.join("config/robots.#{Rails.env}.txt"), :layout => false, :content_type => "text/plain"
  end

  private
end
