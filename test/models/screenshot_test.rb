# == Schema Information
#
# Table name: screenshots
#
#  id               :bigint           not null, primary key
#  game_id          :integer          not null
#  description      :text
#  user_id          :integer          not null
#  title            :string           not null
#  published        :boolean          default(FALSE), not null
#  publication_date :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  image            :string
#  slug             :string
#  aspect_ratio     :integer          default("standard")
#  posted           :boolean          default(FALSE)
#

require 'test_helper'

class ScreenshotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
