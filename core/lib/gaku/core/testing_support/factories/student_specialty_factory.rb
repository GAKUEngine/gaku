FactoryGirl.define do
  factory :student_specialty do
    association(:student)
    association(:specialty)
    is_mayor 1
  end
end
