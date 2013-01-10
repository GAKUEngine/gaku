FactoryGirl.define do
  factory :attendance_type, :class => Gaku::AttendanceType do
    name "Illness"
    color_code 'f0f0f0'
    counted_absent 1
    disable_credit 1
  end
end