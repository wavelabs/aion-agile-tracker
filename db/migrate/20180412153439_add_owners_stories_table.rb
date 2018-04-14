class AddOwnersStoriesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :owners_stories do |t|
      t.integer :owner_id
      t.belongs_to :story, foreign_key: true
      t.timestamps
    end

    add_foreign_key :owners_stories, :users, column: :owner_id
  end
end
