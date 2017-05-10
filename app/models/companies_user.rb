class CompaniesUser < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :role
end
