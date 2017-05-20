# == Schema Information
#
# Table name: stories
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  points         :integer
#  requester_id   :integer
#  story_state_id :integer
#  story_type_id  :integer
#  project_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_stories_on_project_id      (project_id)
#  index_stories_on_story_state_id  (story_state_id)
#  index_stories_on_story_type_id   (story_type_id)
#

class Story < ApplicationRecord
  belongs_to :requester
  delegate :abbr, to: :requester, prefix: true
  belongs_to :story_state
  delegate :display_name, to: :story_state, prefix: true
  belongs_to :story_type
  delegate :display_name, to: :story_type, prefix: true

  POINTS = [0, 1, 2, 3, 5, 8]
end
