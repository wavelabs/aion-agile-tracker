# == Schema Information
#
# Table name: accounts_users
#
#  id         :integer          not null, primary key
#  account_id :integer
#  user_id    :integer
#  role_id    :integer
#
# Indexes
#
#  index_accounts_users_on_account_id  (account_id)
#  index_accounts_users_on_role_id     (role_id)
#  index_accounts_users_on_user_id     (user_id)
#

class AccountsUser < ApplicationRecord
  belongs_to :account
  belongs_to :user
  delegate :email, to: :user, prefix: true
  belongs_to :role
  delegate :name, to: :role, prefix: true

  scope :users, ->() { where(role: Role.user) }

  class << self
    def admin
      find_by(role: Role.admin)
    end
  end
end
