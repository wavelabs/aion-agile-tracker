# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#

FactoryGirl.define do
  factory :project do
    company      { FactoryGirl.create(:company, :with_admin) }
    description  'Project description'
    name         'Project Name'
  end
end
