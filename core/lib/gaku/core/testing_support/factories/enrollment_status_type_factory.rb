FactoryGirl.define do
  factory :enrollment_status_type, :class => Gaku::EnrollmentStatusType do
    name "Enrolled"
    is_active 1
  end
end
