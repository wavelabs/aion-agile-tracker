# == Schema Information
#
# Table name: projects
#
#  id                          :integer          not null, primary key
#  name                        :string
#  description                 :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  account_id                  :integer
#  velocity                    :integer          default("10")
#  iteration_duration_in_weeks :integer          default("1")
#
# Indexes
#
#  index_projects_on_account_id  (account_id)
#
# Agile Project
class Project < ApplicationRecord
  EXTRA_DAY_TO_COMPLETE_WEEK = 1

  belongs_to :account

  has_many :iterations
  has_many :stories, through: :iterations
  has_many :labels, through: :stories
  has_many :story_states

  has_many :collaborators, through: :stories, class_name: 'User', source: :owners

  validates :name, presence: true

  def progress
    total_features = stories.features.count.to_f
    return 0 if total_features == 0.0
    accepted_stories = stories.features.accepted.count.to_f
    (accepted_stories / total_features * 100.0).to_i
  end

  def active_iterations
    iterations.active
  end

  def current_iteration
    iterations.current.first
  end

  def avg_velocity
    avg_no_iterations = 3
    (iterations.last(avg_no_iterations).sum(&:velocity) / avg_no_iterations).to_i
  end

  def count_collaborators
    collaborators.count
  end

  def count_stories
    stories.count
  end

  def find_next_iteration_for_story(story)
    active_iterations.find { |iteration| iteration.story_fits?(story) } ||
      build_iteration_from_last_iteration ||
      build_first_iteration
  end

  def build_iteration_from_last_iteration
    iteration = active_iterations.last
    return unless iteration
    day_diff = (iteration.end_date - iteration.start_date).to_i + EXTRA_DAY_TO_COMPLETE_WEEK
    iterations.build(start_date: iteration.start_date + day_diff.days, end_date: iteration.end_date + day_diff.days, velocity: iteration.velocity)
  end

  def build_first_iteration
    start_date = Date.today.beginning_of_week
    end_date   = start_date + iteration_duration_in_weeks.week - EXTRA_DAY_TO_COMPLETE_WEEK.day
    iterations.build(start_date: start_date, end_date: end_date, velocity: velocity)
  end
end
