class AddGroupToStory < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :group
  end
end
