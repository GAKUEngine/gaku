FactoryGirl.define do
  factory :campus do
    name "Takiko Campus"
    association(:address)
    association(:school)
  end
end