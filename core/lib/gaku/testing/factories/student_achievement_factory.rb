FactoryGirl.define do

  factory :student_achievement, class: Gaku::StudentAchievement do
    student
    achievement
  end

end
