class SubmissionsController < ApplicationController
  def initialize
    @games = Game.showcase
    @tags = ActsAsTaggableOn::Tag.showcase
    super
  end

  def create
    @submission = Submission.new(submission_params)

    if verify_recaptcha(model: @submission) && @submission.save
      flash[:success] = "Your shot is on its way."
      redirect_to controller: 'pages', action: 'submit'
    else
      flash[:error] = "Uh oh, something went wrong. Try again."
      redirect_to controller: 'pages', action: 'submit'
    end
  end

  private

  def submission_params
    params.permit(:email, :image, :game)
  end
end