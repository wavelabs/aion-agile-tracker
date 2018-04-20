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
        role = Role.find_or_create_by(name: 'admin')
        user = create(:user)
        account.accounts_users.create(user: user, role: role)
      end
    end
  end
end
