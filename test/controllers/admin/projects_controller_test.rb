require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'when user sends wrong project params' do
    account = create :account, :with_admin
    admin   = account.admin

    sign_in admin

    post '/admin/projects', params: { project: {name: nil} }
    assert_equal 0, account.projects.count, 'The project has been created'
  end
end
