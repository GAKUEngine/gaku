FactoryGirl.define do

  factory :student_achievement, class: Gaku::StudentAchievement do
    student
    achievement

    factory :invalid_student_achievement do
      student nil
    end
  end

end
