FactoryGirl.define do

  factory :enrollment_status, class: Gaku::EnrollmentStatus do
    code 'enrolled'
    name 'Enrolled'
    active false
    immutable true
  end

  factory :enrollment_status_applicant, class: Gaku::EnrollmentStatus do
    code 'applicant'
    name 'Applicant'
    active false
    immutable true
  end

  factory :enrollment_status_admitted, class: Gaku::EnrollmentStatus do
    code 'admitted'
    name 'Admitted'
    active true
    immutable true
  end

  factory :invalid_enrollment_status, class: Gaku::EnrollmentStatus do
    code nil
  end

end
