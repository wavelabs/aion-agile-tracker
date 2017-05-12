# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  user_id      :integer
#  worked       :float
#  billed       :float
#  description  :text
#  date_started :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#

FactoryGirl.define do
  factory :task do
    project
    user
    worked 1.5
    billed 1.5
    description "MyText"
    date_started "2017-05-10"
  end
end
