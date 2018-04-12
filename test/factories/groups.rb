# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_groups_on_project_id  (project_id)
#

FactoryGirl.define do
  factory :group do
    name "MyString"
    project nil
  end
end
