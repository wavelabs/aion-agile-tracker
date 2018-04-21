# == Schema Information
#
# Table name: iterations
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  project_id :integer
#  velocity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :integer
#
# Indexes
#
#  index_iterations_on_project_id  (project_id)
#

FactoryGirl.define do
  factory :iteration do
    start_date "2018-04-14"
    end_date "2018-04-14"
    project nil
    velocity 1
    number 1

    trait :active do
      start_date { Date.today.beginning_of_week }
      end_date   { Date.today.end_of_week }
    end
  end
end
