class AddVelocityAndIterationDurationInWeeksToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :velocity, :integer, default: 10
    add_column :projects, :iteration_duration_in_weeks, :integer, default: 1
  end
end
