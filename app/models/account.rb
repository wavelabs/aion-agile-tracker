# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ApplicationRecord
  has_many :accounts_users
  has_many :users, through: :accounts_users
  has_many :projects

  scope :owned_by, ->(user) { joins(:users).merge(AccountsUser.admins) }
  scope :belongs,  ->(user) { joins(:users).merge(AccountsUser.users) }

  def admin
    accounts_users.admin.user
  end
  delegate :email, to: :admin, prefix: true

  def count_users
    accounts_users.users.count
  end
end
