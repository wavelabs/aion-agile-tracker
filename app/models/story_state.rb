# == Schema Information
#
# Table name: story_states
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  project_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_story_states_on_project_id  (project_id)
#

class StoryState < ApplicationRecord
end
