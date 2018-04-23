class RemoveGroupsFromStories < ActiveRecord::Migration[5.1]
  def change
    remove_column :stories, :group
  end
end
