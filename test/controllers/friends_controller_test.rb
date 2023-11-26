require "test_helper"

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get friends_show_url
    assert_response :success
  end
end
