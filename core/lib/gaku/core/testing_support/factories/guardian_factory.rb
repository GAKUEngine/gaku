FactoryGirl.define do

  factory :guardian, :class => Gaku::Guardian do
  	name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    relationship "Relationship"
  end

end
