FactoryBot.define do

  factory :course_group_enrollment, class: Gaku::CourseGroupEnrollment do
    course_group
    course
  end

end
