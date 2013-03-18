FactoryGirl.define do
  factory :scholarship_status, :class => Gaku::ScholarshipStatus do
    name 'Self Paid'
    is_default true
  end
end
