class CreateCompaniesUser < ActiveRecord::Migration[5.1]
  def change
    create_table :companies_users do |t|
      t.belongs_to :company, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
