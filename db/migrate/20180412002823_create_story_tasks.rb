class CreateStoryTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :story_tasks do |t|
      t.text :description
      t.boolean :done, default: false
      t.belongs_to :story

      t.timestamps
    end
  end
end
