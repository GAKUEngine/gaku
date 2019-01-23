FactoryBot.define do

  factory :exam_portion_score, class: Gaku::ExamPortionScore do
    score 5.90
    student
    exam_portion
  end

end
