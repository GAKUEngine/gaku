FactoryGirl.define do

  factory :scholarship_status, class: Gaku::ScholarshipStatus do
    name 'Self Paid'
    default true
  end

end
