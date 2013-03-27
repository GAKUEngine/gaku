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
      student.save
    end
  end

  factory :student_with_two_addresses, :parent => :student do
    after_create do |student|
      FactoryGirl.create(:address, :addressable => student)
      FactoryGirl.create(:address, :addressable => student)
      student.save
    end
  end

  factory :student_with_one_contact, :parent => :student do
    after_create do |student|
      contact = FactoryGirl.create(:contact, :contactable => student)
      student.contacts << contact
      student.save
    end

  end

  factory :student_with_two_contacts, :parent => :student do
    after_create do |student|
      student.contacts << FactoryGirl.create(:contact, :contactable => student)
      student.contacts << FactoryGirl.create(:contact, :contactable => student)
      student.save
    end
  end

  factory :student_with_one_guardian, :parent => :student do
    after_create do |student|
      student.guardians << FactoryGirl.create(:guardian)
      student.save
    end
  end


  factory :student_with_one_note, :parent => :student do
    after_create do |student|
      student.notes << FactoryGirl.create(:note, :notable => student)
      student.save
    end
  end


  trait :with_enrollment_status do
    association :enrollment_status, factory: :enrollment_status
  end

  trait :with_scholarship_status do
    association :scholarship_status, factory: :scholarship_status
  end

  trait :with_commute_method_type do
    association :commute_method_type, factory: :commute_method_type
  end

end
