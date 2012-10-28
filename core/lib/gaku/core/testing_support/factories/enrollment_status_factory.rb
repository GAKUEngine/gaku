FactoryGirl.define do
  factory :enrollment_status, :class => Gaku::EnrollmentStatus do
    association(:enrollment_status_type)
    association(:student)
  end
end
