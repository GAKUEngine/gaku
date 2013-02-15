FactoryGirl.define  do
  factory :teacher, :class => Gaku::Teacher do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    gender "male"
  end
end
