# == Schema Information
#
# Table name: submissions
#
#  id         :bigint           not null, primary key
#  image      :string           not null
#  email      :string
#  game       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :image, presence: true

  mount_uploader :image, SubmissionUploader
end
