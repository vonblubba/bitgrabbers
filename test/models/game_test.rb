# == Schema Information
#
# Table name: games
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  year        :integer
#  order       :integer          default(10), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
