# == Schema Information
#
# Table name: story_types
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  icon         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :story_type do
    name "MyString"
    display_name "MyString"
    icon "MyString"
  end
end
