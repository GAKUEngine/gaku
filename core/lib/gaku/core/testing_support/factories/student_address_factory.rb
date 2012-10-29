FactoryGirl.define do
  factory :student_address do
    association(:address)
    association(:student)
  end
end
