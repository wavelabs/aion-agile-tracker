require 'test_helper'

class Admin::CompaniesUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_companies_users_destroy_url
    assert_response :success
  end

end
