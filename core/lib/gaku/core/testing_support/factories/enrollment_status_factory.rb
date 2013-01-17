FactoryGirl.define do
  factory :enrollment_status, :class => Gaku::EnrollmentStatus do
    code 'admitted'
    name "Admitted"
    is_active true
    immutable true
  end
end
