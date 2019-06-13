class PagesController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    @q = Screenshot.ransack("")
    super
  end

  def index
    @screenshots = Screenshot.order(publication_date: :desc).limit(9)
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

  private
end
