FactoryGirl.define  do

  factory :student, class: Gaku::Student do
    name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    name_reading { Faker::Name.first_name }
    surname_reading { Faker::Name.last_name }
    gender 'male'
    birth_date Date.today
  end

  factory :student_with_one_guardian, parent: :student do
    after(:create) do |student|
      student.guardians << create(:guardian)
      student.save
    end
  end

  trait :with_course do
    after(:create) do |student|
      student.courses << create(:course)
      student.save
    end
  end

  trait :with_enrollment_status do
    enrollment_status
  end

  trait :admitted do
    deleted false
    #admitted false
    association :enrollment_status, factory: :enrollment_status_admitted
  end

  trait :applicant do
    deleted false
    #admitted false
    association :enrollment_status, factory: :enrollment_status_applicant
  end

  trait :with_scholarship_status do
    scholarship_status
  end

  trait :with_commute_method_type do
    commute_method_type
  end

end
