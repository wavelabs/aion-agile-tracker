# == Schema Information
#
# Table name: stories
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  points       :integer          default("-1")
#  requester_id :integer
#  project_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  story_type   :string
#  story_state  :string
#  iteration_id :integer
#  position     :integer
#
# Indexes
#
#  index_stories_on_iteration_id  (iteration_id)
#  index_stories_on_project_id    (project_id)
#

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
