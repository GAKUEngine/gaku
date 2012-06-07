FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    address { Faker::Address::street_address }
    phone { Faker::PhoneNumber::phone_number }
    email { Faker::Internet::email }
  end
end