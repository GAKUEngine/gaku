FactoryGirl.define do

  factory :simple_grade_type, class: Gaku::SimpleGradeType do
    sequence(:name) { |n | "ruby_#{n}" }
    grading_method
    school

    factory :invalid_simple_grade_type do
      name nil
    end
  end

end
