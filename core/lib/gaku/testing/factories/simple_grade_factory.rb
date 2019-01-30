FactoryBot.define do
  factory :simple_grade, class: Gaku::SimpleGrade do
    score { 2.5 }
    award_date { Date.today }
    simple_grade_type
    student

    factory :invalid_simple_grade do
      score { nil }
    end
  end
end
