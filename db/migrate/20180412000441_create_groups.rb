class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
