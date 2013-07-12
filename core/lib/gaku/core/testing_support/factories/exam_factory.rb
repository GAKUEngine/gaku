FactoryGirl.define do

	factory :exam, class: Gaku::Exam do
    name "Math exam"
    weight 4
    use_weighting true
    after(:build) do |exam|
      exam.exam_portions << FactoryGirl.build(:exam_portion, exam: exam)
    end
  end

  trait :with_portions do
    after(:create) do |exam|
      exam.exam_portions << FactoryGirl.create(:exam_portion, exam: exam)
      exam.exam_portions << FactoryGirl.create(:exam_portion, exam: exam)
      exam.save
    end
  end

end
