FactoryGirl.define do
  factory :assignment_score, :class => Gaku::AssignmentScore do
    score 6
    association(:student)
  end
end
