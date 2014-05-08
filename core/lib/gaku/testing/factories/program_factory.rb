FactoryGirl.define do

  factory :program, class: Gaku::Program do
    name { Faker::Education.degree }
    description 'Superior Ruby Skills'
    school
  end

  trait :full_program do |resource|
    resource.after(:build) do |program|
      level = create(:level)
      syllabus = create(:syllabus)
      specialty = create(:specialty)
      create(:program_level, level: level, program: program)
      create(:program_syllabus, level: level, program: program, syllabus: syllabus)
      create(:program_specialty, specialty: specialty, program: program)
    end
  end

  trait :with_program_level do |resource|
    resource.after(:build) do |program|
      program.levels << create(:level)
    end
  end

  trait :with_program_syllabus do |resource|
    resource.after(:build) do |program|
      program.syllabuses << create(:syllabus)
    end
  end

  trait :with_program_specialty do |resource|
    resource.after(:build) do |program|
      program.specialties << create(:specialty)
    end
  end

end
