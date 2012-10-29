FactoryGirl.define do
  factory :contact do
    data "gaku@example.com"
    association(:contact_type)
    details "My email"
  end
end
