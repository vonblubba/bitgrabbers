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

FactoryBot.define do
  factory :submission do
    
  end
end
