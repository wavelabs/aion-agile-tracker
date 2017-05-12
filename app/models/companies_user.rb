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
