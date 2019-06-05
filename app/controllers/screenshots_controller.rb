class ScreenshotsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def show
    @screenshot = Screenshot.friendly.find(params[:id])
    @page_title = @screenshot.title
  end
end