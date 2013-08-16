FactoryGirl.define do

  factory :class_group_enrollment, class: Gaku::ClassGroupEnrollment do
    class_group
    student
    seat_number 5
  end

end
