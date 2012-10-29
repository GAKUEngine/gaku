FactoryGirl.define do
  factory :student_address, :class => Gaku::StudentAddress do
    association(:address)
    association(:student)
  end
end
