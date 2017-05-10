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
