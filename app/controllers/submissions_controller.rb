class SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        flash[:notice] = 'Your shot is on its way.'
        format.html  { redirect_to(:controller => "pages", :action => "submit") }
      else
        format.html  { render "pages/submit" }
      end
    end
  end

  private

  def submission_params
    params.require(:email)
    params.permit(:email, :image, :game)
  end
end