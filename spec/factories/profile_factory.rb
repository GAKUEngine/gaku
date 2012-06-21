FactoryGirl.define do
  factory :profile do
    email { Faker::Internet::email }
    birth_date { Time.now - 18.years }
  end
end