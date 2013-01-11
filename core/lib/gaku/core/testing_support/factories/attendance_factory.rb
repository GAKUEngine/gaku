FactoryGirl.define do
  factory :attendance, :class => Gaku::Attendance do
    reason 'headache'
    after_build do |attendance|
      attendance.attendance_type = FactoryGirl.build(:attendance_type, :attendances => [attendance])
    end
  end
end
