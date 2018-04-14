class DropStoryStates < ActiveRecord::Migration[5.1]
  def change
    drop_table :story_states
  end
end
