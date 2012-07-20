FactoryGirl.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    phone { Faker::PhoneNumber::phone_number }
    email { Faker::Internet::email }
    gender "male"
    after_create { |student| FactoryGirl.create(:note, :student => student) }
  end
end