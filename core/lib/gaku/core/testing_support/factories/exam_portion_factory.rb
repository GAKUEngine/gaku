FactoryGirl.define do
  factory :exam_portion, :class => Gaku::ExamPortion do
    name "1st"
    max_score  100
    weight 100
    problem_count 1

    association(:exam)
  end
end
