FactoryGirl.define do
  factory :semester_course, :class => Gaku::SemesterCourse do
    association(:semester)
    association(:course)
  end
end
