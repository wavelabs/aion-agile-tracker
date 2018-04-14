require 'test_helper'

class Admin::EstimateControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get put" do
    get admin_estimate_controller_put_url
    assert_response :success
  end

end
