FactoryGirl.define do

  factory :semester_course, class: Gaku::SemesterCourse do
    semester
    course
  end

end
