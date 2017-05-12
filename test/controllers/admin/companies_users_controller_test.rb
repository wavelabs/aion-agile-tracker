require 'test_helper'

class Admin::CompaniesUsersControllerTest < ActionDispatch::IntegrationTest
  test "should delete destroy" do
    user = create :user, :admin
    sign_in user
    delete companies_user_url(user.id)
    assert_response :success
  end

end
