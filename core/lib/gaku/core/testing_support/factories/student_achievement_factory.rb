FactoryGirl.define do
  factory :student_achievement, :class => Gaku::StudentAchievement do
    association(:student)
    association(:achievement)
  end
end
