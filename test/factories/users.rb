FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "sample+#{n}@example.com" }
    password              '123123123'
    password_confirmation '123123123'

    trait :admin do
      after(:create) do |user, evaluator|
        company = create :company
        company.companies_users.create(user: user, role: Role.admin)
      end
    end
  end
end
