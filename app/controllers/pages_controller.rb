class PagesController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def index
    @screenshots = Screenshot.published.order(created_at: :desc).limit(20)
  end

  def about
    @page_title = 'About us'
    @screenshots_count = Screenshot.published.count
    @games_count = Game.all.count
  end

  def submit
    @page_title = 'Submit your shots'
  end
end
