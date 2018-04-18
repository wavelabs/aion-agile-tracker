# == Schema Information
#
# Table name: projects
#
#  id                          :integer          not null, primary key
#  name                        :string
#  description                 :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  account_id                  :integer
#  velocity                    :integer          default("10")
#  iteration_duration_in_weeks :integer          default("1")
#
# Indexes
#
#  index_projects_on_account_id  (account_id)
#

FactoryGirl.define do
  factory :project do
    account      { FactoryGirl.create(:account, :with_admin) }
    description  'Project description'
    name         'Project Name'

    trait :with_active_iteration do
      after(:create) do |project, evaluator|
        project.iterations << create(:iteration, :active, project: project)
      end
    end
  end
end
