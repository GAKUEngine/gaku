FactoryGirl.define do
  factory :campus do
    name "Takiko Campus"
    address { |campus| campus.association(:address) }
    school  { |campus| campus.association(:school) }
  end
end