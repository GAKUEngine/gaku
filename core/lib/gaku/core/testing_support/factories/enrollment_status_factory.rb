FactoryGirl.define do
  
  factory :enrollment_status_applicant, :class => Gaku::EnrollmentStatus do
    code 'applicant' 
    name 'Applicant'
    is_active false
    immutable true
  end
  
  factory :enrollment_status_admitted, :class => Gaku::EnrollmentStatus do
    code 'admitted' 
    name 'Admitted'
    is_active true
    immutable true
  end

end
