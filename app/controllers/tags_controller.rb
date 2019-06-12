class TagsController < ApplicationController

  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    @screenshots = Screenshot.published.tagged_with(@tag.name).order("screenshots.created_at DESC")
    @page_title = "#{@tag.name.capitalize} screenshots"
  end
end