FactoryGirl.define  do
  factory :teacher, :class => Gaku::Teacher do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    gender "male"
  end

  factory :teacher_with_one_address, :parent => :teacher do
    after_create do |teacher|
      FactoryGirl.create(:address, :addressable => teacher)
    end
  end

  factory :teacher_with_two_addresses, :parent => :teacher do
    after_create do |teacher|
      FactoryGirl.create(:address, :addressable => teacher)
      FactoryGirl.create(:address, :addressable => teacher)
    end
  end

  factory :teacher_with_one_contact, :parent => :teacher do
    after_create do |teacher|
      FactoryGirl.create(:contact, :contactable => teacher)
    end
  end

  factory :teacher_with_two_contacts, :parent => :teacher do
    after_create do |teacher|
      FactoryGirl.create(:contact, :contactable => teacher)
      FactoryGirl.create(:contact, :contactable => teacher)
    end
  end

  trait :with_one_note do
    after_create do |teacher|
      FactoryGirl.create(:note, :notable => teacher)
    end
  end

end
