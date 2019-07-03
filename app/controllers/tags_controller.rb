class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    @meta_description = "All screenshots for tag #{@tag.name} featured on bitgrabbers"
    @screenshots = Screenshot.published.tagged_with(@tag.name).order("screenshots.created_at DESC")
    @page_title = "Screenshots tagged #{@tag.name} | Bitgrabbers"
  end
end