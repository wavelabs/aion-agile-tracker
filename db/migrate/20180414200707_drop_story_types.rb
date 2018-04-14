class DropStoryTypes < ActiveRecord::Migration[5.1]
  def change
    drop_table :story_types
  end
end
