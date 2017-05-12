# == Schema Information
#
# Table name: companies_users
#
#  id         :integer          not null, primary key
#  company_id :integer
#  user_id    :integer
#  role_id    :integer
#
# Indexes
#
#  index_companies_users_on_company_id  (company_id)
#  index_companies_users_on_role_id     (role_id)
#  index_companies_users_on_user_id     (user_id)
#

class CompaniesUser < ApplicationRecord
  belongs_to :company
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
