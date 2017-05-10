class CompaniesUser < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :role

  scope :users, ->() { where(role: Role.user) }

  class << self
    def admin
      find_by(role: Role.admin)
    end
  end
end
