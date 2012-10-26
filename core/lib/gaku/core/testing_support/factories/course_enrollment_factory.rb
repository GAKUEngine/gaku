FactoryGirl.define do
  factory :course_enrollment, :class => Gaku::CourseEnrollment do
    association(:course)
    association(:student)
  end
end
