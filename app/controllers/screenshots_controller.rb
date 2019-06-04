class ScreenshotsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def index
  end

  def show
  end
end