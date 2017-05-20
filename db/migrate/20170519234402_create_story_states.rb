class CreateStoryStates < ActiveRecord::Migration[5.1]
  def change
    create_table :story_states do |t|
      t.string :name
      t.string :display_name
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
