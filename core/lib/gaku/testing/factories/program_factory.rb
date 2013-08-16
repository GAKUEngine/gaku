FactoryGirl.define do

  factory :program, class: Gaku::Program do
    name 'Advanced Ruby'
    description 'Superior Ruby Skills'
    school
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
