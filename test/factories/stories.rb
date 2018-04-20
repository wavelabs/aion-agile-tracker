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
#  position     :integer
#
# Indexes
#
#  index_stories_on_iteration_id  (iteration_id)
#  index_stories_on_project_id    (project_id)
#

FactoryGirl.define do
  factory :story do
    title "MyString"
    description "MyText"
    points 1
    requester { FactoryGirl.build(:requester) }

    trait :estimated do
      points 1
    end

    trait :unestimated do
      points -1
    end

    trait :feature do
      story_type 'feature'
    end
  end
end
