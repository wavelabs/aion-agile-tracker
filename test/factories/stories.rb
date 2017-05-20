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

FactoryGirl.define do
  factory :story do
    title "MyString"
    description "MyText"
    points 1
    requester_id 1
    state_id 1
  end
end
