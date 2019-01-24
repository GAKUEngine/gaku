FactoryBot.define  do

  factory :teacher, class: Gaku::Teacher do
    name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }
    name_reading { FFaker::Name.first_name }
    surname_reading { FFaker::Name.last_name }
    gender true

    factory :invalid_teacher do
      name nil
    end
  end

end
