FactoryGirl.define do
  factory :course_enrollment do
    association(:course)
    association(:student)
  end
end
