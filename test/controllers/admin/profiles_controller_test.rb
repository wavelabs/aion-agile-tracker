require 'test_helper'

class Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_profiles_show_url
    assert_response :success
  end

end
