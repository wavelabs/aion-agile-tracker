require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'when creates a new account it makes you owner' do
    account = create :account, :with_admin
    admin   = account.admin

    sign_in admin

    post '/admin/accounts', params: { account: { name: 'Today' } }
    assert Account.owned_by(admin).where(name: 'Today').exists
  end
end
