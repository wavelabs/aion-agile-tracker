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
#  number     :integer
#
# Indexes
#
#  index_iterations_on_project_id  (project_id)
#

class Iteration < ApplicationRecord
  belongs_to :project
  has_many :stories, dependent: :destroy

  scope :active,  ->() { where('? <= end_date', Date.today) }
  scope :done,    ->() { where('? > end_date', Date.today) }
  scope :from_id, ->(id) { where('id > ?', id) }

  accepts_nested_attributes_for :stories

  def self.current
    active.find_by('start_date <= ?', Date.today)
  end

  def current?
    (start_date...end_date).include? Date.today
  end

  def total_points
    stories.estimated.sum(:points)
  end

  def points_done
    stories.estimated.accepted.sum(:points)
  end

  def count_story_done
    stories.done.count
  end

  def story_fits?(story)
    !story.estimated? || (story.points + total_points) <= velocity
  end
end
