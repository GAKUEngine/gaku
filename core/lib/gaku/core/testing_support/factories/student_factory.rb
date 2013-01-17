FactoryGirl.define  do
  factory :student, :class => Gaku::Student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    gender "male"
  end

  factory :student_with_one_address, :parent => :student do
    after_create do |student|
      FactoryGirl.create(:address, :addressable => student)
    end
  end

  factory :student_with_two_addresses, :parent => :student do
    after_create do |student|
      FactoryGirl.create(:address, :addressable => student)
      FactoryGirl.create(:address, :addressable => student)
    end
  end

  factory :student_with_one_contact, :parent => :student do
    after_create do |student|
      FactoryGirl.create(:contact, :contactable => student)
    end
  end

  factory :student_with_two_contacts, :parent => :student do
    after_create do |student|
      FactoryGirl.create(:contact, :contactable => student)
      FactoryGirl.create(:contact, :contactable => student)
    end
  end

end
