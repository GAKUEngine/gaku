FactoryGirl.define do
  factory :class_group_enrollment, :class => Gaku::ClassGroupEnrollment do
    association(:class_group)
    association(:student)
    seat_number 5
  end
end
