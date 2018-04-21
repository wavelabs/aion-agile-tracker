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

    Story::TYPES.each do |type|
      trait type.to_sym do
        story_type type
      end
    end

    Story.aasm.states.map(&:name).each do |state|
      trait state.to_sym do
        story_state state
      end
    end
  end
end
