FactoryGirl.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    phone { Faker::PhoneNumber::phone_number }
    email { Faker::Internet::email }
    after_create { |student| FactoryGirl.create(:note, :student => student) }
  end
end