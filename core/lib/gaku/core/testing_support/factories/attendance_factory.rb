FactoryGirl.define do
  factory :attendance, class: Gaku::Attendance do
    reason 'headache'
    after(:build) do |attendance|
      attendance.attendance_type = build(:attendance_type)
      attendance.student = build(:student)
    end
  end
end
