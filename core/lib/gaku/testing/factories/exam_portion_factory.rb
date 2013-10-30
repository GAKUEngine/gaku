FactoryGirl.define do

  factory :exam_portion, class: Gaku::ExamPortion do
    name 'wow'
    max_score  100
    weight 100
    problem_count 1
    exam

    factory :invalid_exam_portion do
      name ''
    end
  end

end
