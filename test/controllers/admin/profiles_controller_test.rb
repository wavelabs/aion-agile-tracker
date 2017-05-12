require 'test_helper'

class Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = create :user, :admin
    sign_in user
    get user_profile_url(user)
    assert_response :success
  end

end
