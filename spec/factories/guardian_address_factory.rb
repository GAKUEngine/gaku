FactoryGirl.define do
  factory :guardian_address do
    association(:address)
    association(:guardian)
  end
end
