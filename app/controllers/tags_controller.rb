class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    @screenshots = Screenshot.published.tagged_with(@tag.name).order("screenshots.created_at DESC")
    @page_title = "Screenshots tagged #{@tag.name} | Bitgrabbers"
  end
end