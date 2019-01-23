FactoryBot.define do

  factory :exam_score, class: Gaku::ExamScore do
    exam
    score 6
    comment 'Excellent score'
  end

end
