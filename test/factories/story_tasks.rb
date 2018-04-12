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

FactoryGirl.define do
  factory :story_task do
    description "MyText"
    done false
  end
end
