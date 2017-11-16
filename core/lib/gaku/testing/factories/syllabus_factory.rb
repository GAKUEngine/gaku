FactoryGirl.define do

  factory :syllabus, class: Gaku::Syllabus do
    name { FFaker::Name.name }
    code '12345'
    description 'Short description'
    credits 'Huge Credits'

    factory :invalid_syllabus do
      code nil
    end
  end

  trait :with_exam do
    after(:create) do |syllabus|
      syllabus.exams << create(:exam)
    end
  end

end
