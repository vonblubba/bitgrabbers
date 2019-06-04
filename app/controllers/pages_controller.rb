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
  end

  def submit

  end
end
