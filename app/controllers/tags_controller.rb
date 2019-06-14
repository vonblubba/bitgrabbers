class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    @screenshots = Screenshot.published.tagged_with(@tag.name).order("screenshots.created_at DESC")
    @page_title = "#{@tag.name.capitalize} screenshots"
  end
end