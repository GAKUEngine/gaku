FactoryGirl.define do

  factory :course_enrollment, class: Gaku::CourseEnrollment do
    course
    student
  end

end
