class PagesController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ['science fiction', 'fantasy']
    super
  end

  def index
  end

  def about
  end

  def submit

  end
end
