class CreateIterations < ActiveRecord::Migration[5.1]
  def change
    create_table :iterations do |t|
      t.date :start_date
      t.date :end_date
      t.belongs_to :project, foreign_key: true
      t.integer :velocity

      t.timestamps
    end
  end
end
