FactoryGirl.define do

  factory :exam_portion, class: Gaku::ExamPortion do
    name 'wow'
    max_score 100
    weight 100
    problem_count 1
    exam
    score_type 'score'
    factory(:invalid_exam_portion) { name nil }
  end

end
