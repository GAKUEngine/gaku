FactoryGirl.define do
  factory :course_group_enrollment do
    association(:course_group)
    association(:course)
  end
end
