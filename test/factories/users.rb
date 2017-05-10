FactoryGirl.define do
  factory :user do
    email                 'sample@example.com'
    password              '123123123'
    password_confirmation '123123123'
  end
end
