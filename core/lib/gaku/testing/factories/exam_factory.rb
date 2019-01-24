FactoryBot.define do
  factory :exam, class: Gaku::Exam do
    name { 'Math exam' }
    weight { 4 }
    use_weighting { true }

    factory :invalid_exam do
      name { nil }
    end
  end

  trait :with_portion do
    after(:create) do |exam|
      exam.exam_portions << create(:exam_portion, exam: exam)
      exam.save
    end
  end

  trait :with_portions do
    after(:create) do |exam|
      exam.exam_portions << create(:exam_portion, exam: exam)
      exam.exam_portions << create(:exam_portion, exam: exam)
      exam.save
    end
  end
end
