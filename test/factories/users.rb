FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "sample+#{n}@example.com" }
    password              '123123123'
    password_confirmation '123123123'
  end
end
