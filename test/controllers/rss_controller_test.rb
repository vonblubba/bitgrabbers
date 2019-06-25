require 'test_helper'

class RssControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get rss_Index_url
    assert_response :success
  end

end
