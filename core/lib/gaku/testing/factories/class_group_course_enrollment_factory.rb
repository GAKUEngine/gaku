FactoryGirl.define do

  factory :class_group_course_enrollment, class: Gaku::ClassGroupCourseEnrollment do
    class_group
    course
  end

end
