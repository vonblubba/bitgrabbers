class ScreenshotsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ['science fiction', 'fantasy']
    super
  end

  def index
  end

  def show
  end
end