# == Schema Information
#
# Table name: stories
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  points       :integer
#  requester_id :integer
#  project_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  story_type   :string
#  story_state  :string
#  group        :string
#  iteration_id :integer
#
# Indexes
#
#  index_stories_on_iteration_id  (iteration_id)
#  index_stories_on_project_id    (project_id)
#

class Story < ApplicationRecord
  include AASM

  acts_as_taggable_on :labels
  acts_as_commentable

  TYPES  = %w(feature chore bug release).freeze
  GROUPS = %w(current backlog icebox).freeze
  POINTS = [-1, 0, 1, 2, 3, 5, 8]

  scope :current, ->() { where(group: 'current').where.not(iteration_id: nil) }
  scope :backlog, ->() { where(group: 'backlog', iteration_id: nil) }
  scope :icebox,  ->() { where(group: 'icebox', iteration_id: nil) }

  belongs_to :project
  belongs_to :requester
  delegate :abbr, to: :requester, prefix: true
  belongs_to :iteration

  has_many :story_tasks
  alias_method :tasks, :story_tasks

  has_many :owners_stories, dependent: :destroy
  has_many :owners, -> { distinct }, through: :owners_stories

  scope :count_and_group_by_story_states, ->() do
    group(:story_state).count
  end

  aasm column: 'story_state' do
    state :unstarted, :initial => true
    state :started, :finished, :delivered, :rejected, :accepted

    after_all_transitions :add_owner

    event :start do
      transitions from: [:unstarted, :rejected], to: :started, after: :move_to_current_iteration
    end

    event :finish do
      transitions from: :started, to: :finished
    end

    event :deliver do
      transitions from: :finished, to: :delivered
    end

    event :accept do
      transitions from: :delivered, to: :accepted, after: :calculate_iteration_velocity
    end

    event :reject do
      transitions from: :delivered, to: :rejected
    end
  end

  def add_owner(owner)
    return if owners.include? owner
    owners << owner
  end

  def move_to_current_iteration
    return if iteration == project.current_iteration
    update(iteration: project.current_iteration)
  end

  def estimated?
    points != POINTS.first
  end

  TYPES.each do |type|
    define_method("#{type}?") { self.story_type == type }
  end

  private

  def calculate_iteration_velocity
    self.iteration.calculate_iteration_velocity
  end

end