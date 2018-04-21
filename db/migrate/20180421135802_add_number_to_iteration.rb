class AddNumberToIteration < ActiveRecord::Migration[5.1]
  def change
    add_column :iterations, :number, :integer
  end
end
