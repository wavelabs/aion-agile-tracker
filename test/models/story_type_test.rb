# == Schema Information
#
# Table name: story_types
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  icon         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class StoryTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
