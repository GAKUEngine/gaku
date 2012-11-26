FactoryGirl.define do
  factory :course_group_enrollment, :class => Gaku::CourseGroupEnrollment do
    association(:course_group)
    association(:course)
  end
end
