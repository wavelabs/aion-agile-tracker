# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :account do
    name         'Company Name'

    trait :with_admin do
      after(:create) do |account, evaluator|
        user = create(:user)
        account.accounts_users.create(user: user, role: Role.admin)
      end
    end
  end
end
