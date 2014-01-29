FactoryGirl.define do

  factory :guardian, class: Gaku::Guardian do
  	name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    relationship 'Relationship'

    factory :invalid_guardian do
      name nil
    end
  end

end
