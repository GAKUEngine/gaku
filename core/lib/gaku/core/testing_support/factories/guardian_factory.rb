FactoryGirl.define do
  factory :guardian do
  	name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    relationship "Relationship" 
  end
end
