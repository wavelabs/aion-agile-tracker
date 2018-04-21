class AddDefaultStoryPointToStories < ActiveRecord::Migration[5.1]
  def change
    change_column(:stories, :points, :integer, default: -1)
  end
end
