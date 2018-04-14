class ReplaceGroupByString < ActiveRecord::Migration[5.1]
  def change
    remove_reference :stories, :group
    add_column :stories, :group, :string
  end
end
