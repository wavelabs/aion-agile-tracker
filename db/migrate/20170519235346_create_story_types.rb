class CreateStoryTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :story_types do |t|
      t.string :name
      t.string :display_name
      t.string :icon

      t.timestamps
    end
  end
end
