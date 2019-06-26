# == Schema Information
#
# Table name: games
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  in_menu     :boolean          default(FALSE)
#

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
