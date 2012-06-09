FactoryGirl.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name::last_name }
    email { Faker::Internet::email }
    birth_date { Time.now - 18.years }
  end
end