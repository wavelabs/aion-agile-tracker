require 'test_helper'

class Admin::Users::InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_role = Role.find_or_create_by(name: 'admin')
    @user_role  = Role.find_or_create_by(name: 'user')
    @admin      = create :user, :admin
    @account    = @admin.accounts.first

    sign_in @admin
  end

  test 'when user does not exists invite, create and relate to current user accounts' do
    post "/admin/accounts/#{@account.id}/invitation", params: { user: { email: 'sample@sample.com' } }
    user    = User.find_by(email: 'sample@sample.com')
    account = Account.owned_by(user).first

    assert user
    assert account
    assert_includes @account.users, user
  end

  test 'when user exists relate it to current user company' do
    user   = create :user, :admin
    post "/admin/accounts/#{@account.id}/invitation", params: { user: { email: user.email } }

    assert_nil Account.find_by(name: user.email)
    assert_includes @account.users, user
  end
end
