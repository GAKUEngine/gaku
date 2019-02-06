FactoryBot.define do
  factory :course, class: Gaku::Course do
    code { 'A1' }

    factory(:invalid_course) { code { nil } }

    trait :with_student do
      after(:create) do |course|
        course.students << create(:student)
        course.save
      end
    end
  end
end
