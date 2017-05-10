FactoryGirl.define do
  factory :project do
    company      { FactoryGirl.create(:company, :with_admin) }
    description  'Project description'
    name         'Project Name'
  end
end
