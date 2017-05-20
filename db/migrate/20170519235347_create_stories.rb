class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.integer :points
      t.integer :requester_id
      t.belongs_to :story_state, foreign_key: true
      t.belongs_to :story_type, foreign_key: true
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end

    add_foreign_key(:stories, :users, column: :requester_id, primary_key: :id)
  end
end
