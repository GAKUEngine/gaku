FactoryGirl.define do
  factory :program, :class => Gaku::Program do
    name 'Advanced Ruby'
    description 'Superior Ruby Skills'
  end


  trait :with_program_level do |resource|
    resource.after(:build) do |program|
      program.levels << FactoryGirl.create(:level)
    end
  end

  trait :with_program_syllabus do |resource|
    resource.after(:build) do |program|
      program.syllabuses << FactoryGirl.create(:syllabus)
    end
  end

  trait :with_program_specialty do |resource|
    resource.after(:build) do |program|
      program.specialties << FactoryGirl.create(:specialty)
    end
  end

end
