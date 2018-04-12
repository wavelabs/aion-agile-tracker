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
#  group_id       :integer
#
# Indexes
#
#  index_stories_on_group_id        (group_id)
#  index_stories_on_project_id      (project_id)
#  index_stories_on_story_state_id  (story_state_id)
#  index_stories_on_story_type_id   (story_type_id)
#

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
