FactoryBot.define do

  factory :semester_attendance, class: Gaku::SemesterAttendance do
    student
    semester
  end

end
