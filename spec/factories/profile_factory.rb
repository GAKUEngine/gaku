FactoryGirl.define do
  factory :profile do
    name { Faker::Name.first_name }
    surname { Faker::Name::last_name }
    email { Faker::Internet::email }
    birth_date { Time.now - 18.years }
  end
end