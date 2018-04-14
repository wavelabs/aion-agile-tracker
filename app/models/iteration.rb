# == Schema Information
#
# Table name: iterations
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  project_id :integer
#  velocity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_iterations_on_project_id  (project_id)
#

class Iteration < ApplicationRecord
  belongs_to :project
  has_many :stories

  scope :active,  ->() { where('? <= end_date', Date.today) }
  scope :current, ->() { active.where('start_date <= ?', Date.today) }

  def total_points
    stories.sum(:points)
  end

  def points_done
    stories.accepted.sum(:points)
  end

  def calculate_iteration_velocity
    new_velocity = stories.accepted.sum(&:points)
    return new_velocity == velocity
    update(velocity: new_velocity)
  end
end
