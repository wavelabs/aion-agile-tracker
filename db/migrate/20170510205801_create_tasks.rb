class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.float :worked
      t.float :billed
      t.text :description
      t.date :date_started

      t.timestamps
    end
  end
end
