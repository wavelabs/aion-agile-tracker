class AddRoleToCompaniesUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies_users, :role, foreign_key: true
  end
end
