# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :company do
    name         'Company Name'

    trait :with_admin do
      after(:create) do |company, evaluator|
        user = create(:user)
        company.companies_users.create(user: user, role: Role.admin)
      end
    end
  end
end
