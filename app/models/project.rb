# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#

class Project < ApplicationRecord
  belongs_to :company

  has_many :stories
  has_many :story_states
  has_many :iterations

  def progress
    stories.count_and_group_by_story_states
  end

  def active_iterations
    iterations.active
  end

  def current_iteration
    iterations.current.first
  end

  def avg_velocity
    (iterations.last(3).sum(&:velocity) / 3).to_i
  end

  def find_next_iteration_for_story(story)
    active_iterations.find do |iteration|
      !story.estimated? || (story.points + iteration.total_points) <= iteration.velocity
    end || build_iteration_from_last_iteration || build_first_iteration
  end

  def build_iteration_from_last_iteration
    iteration = active_iterations.last
    return unless iteration
    iterations.build(start_date: iteration.start_date + 1.week, end_date: iteration.end_date + 1.week, velocity: iteration.velocity)
  end

  def build_first_iteration
    today = Date.today
    iterations.build(start_date: today.beginning_of_week, end_date: today.end_of_week, velocity: 10)
  end
end
