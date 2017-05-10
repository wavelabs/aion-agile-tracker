class AddCompanyToProject < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :company, foreign_key: true
  end
end
