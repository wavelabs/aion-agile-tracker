FactoryGirl.define do
  factory :task do
    project nil
    user nil
    worked 1.5
    billed 1.5
    description "MyText"
    date_started "2017-05-10"
  end
end
