class AddReleaseDateToStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :release_date, :date
  end
end
