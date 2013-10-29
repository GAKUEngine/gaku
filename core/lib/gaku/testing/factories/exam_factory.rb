FactoryGirl.define do

	factory :exam, class: Gaku::Exam do
    name 'Math exam'
    weight 4
    use_weighting true
    after(:build) do |exam|
      exam.exam_portions << build(:exam_portion, exam: exam)
    end

    factory :invalid_exam do
      name nil
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
