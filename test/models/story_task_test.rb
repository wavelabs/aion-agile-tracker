# == Schema Information
#
# Table name: story_tasks
#
#  id          :integer          not null, primary key
#  description :text
#  done        :boolean          default("false")
#  story_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_story_tasks_on_story_id  (story_id)
#

require 'test_helper'

class StoryTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
