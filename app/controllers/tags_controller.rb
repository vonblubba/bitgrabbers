class TagsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def show
    @screenshots = Screenshot.published.tagged_with(params[:id]).order("screenshots.created_at DESC")
  end
end