class ChangeStoryStateAndTypeByString < ActiveRecord::Migration[5.1]
  def change
    remove_reference :stories, :story_state
    remove_reference :stories, :story_type

    add_column :stories, :story_type,  :string
    add_column :stories, :story_state, :string
  end
end
