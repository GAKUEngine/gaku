require 'ffaker'

FactoryBot.define do
  factory :student, class: Gaku::Student do
    name { FFaker::Name.first_name }
    middle_name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }
    name_reading { FFaker::Name.first_name }
    surname_reading { FFaker::Name.last_name }
    gender { true }
    birth_date { Date.today }
    picture { FFaker::Image.file }
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

  trait :with_class_group do
    after(:create) do |student|
      student.class_groups << create(:class_group)
      student.save
    end
  end

  trait :with_extracurricular_activity do
    after(:create) do |student|
      student.extracurricular_activities << create(:extracurricular_activity)
      student.save
    end
  end

  trait :with_enrollment_status do
    enrollment_status
  end

  trait :admitted do
    association :enrollment_status, factory: :enrollment_status_admitted
  end

  trait :applicant do
    association :enrollment_status, factory: :enrollment_status_applicant
  end

  trait :with_scholarship_status do
    scholarship_status
  end

  trait :with_commute_method_type do
    commute_method_type
  end
end
