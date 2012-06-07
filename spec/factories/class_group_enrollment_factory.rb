FactoryGirl.define do
  factory :class_group_enrollment do
    association(:class_group)
    association(:student)
  end
end