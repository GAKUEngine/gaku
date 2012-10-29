FactoryGirl.define do
  factory :exam_score do
    association(:exam)
    score  6 
    comment "Excellent score"
  end
end
