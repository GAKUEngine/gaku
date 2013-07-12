FactoryGirl.define do

  factory :syllabus, class: Gaku::Syllabus do
    name { Faker::Name.name }
    code '12345'
    description 'Short description'
    credits 'Huge Credits'
  end

  trait :with_exam do
    after(:create) do |syllabus|
      syllabus.exams << FactoryGirl.create(:exam)
    end
  end

end
