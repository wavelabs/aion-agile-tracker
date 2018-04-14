# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  has_many :companies_users
  has_many :users, through: :companies_users
  has_many :projects

  def admin
    companies_users.admin.user
  end
  delegate :email, to: :admin, prefix: true

  def count_users
    companies_users.users.count
  end
end
