require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'when creates a new account it makes you owner' do
    account = create :account, :with_admin
    admin   = account.admin

    sign_in admin

    post '/admin/accounts', params: { account: { name: 'Today' } }
    assert Account.owned_by(admin).where(name: 'Today').exists
  end

  test 'POST #create with wrong params' do
    account = create :account, :with_admin
    admin   = account.admin

    sign_in admin

    post '/admin/accounts', params: { account: { name: nil } }
    assert_equal 1, Account.owned_by(admin).count
  end

  test 'PATCH #update with wrong params' do
    account = create :account, :with_admin
    admin   = account.admin

    sign_in admin

    put "/admin/accounts/#{account.id}", params: { account: { name: nil } }
    assert_equal account.name, account.reload.name
  end
end
