class ScreenshotsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def index
  end

  def show
    @screenshot = Screenshot.friendly.find(params[:id])
  end
end