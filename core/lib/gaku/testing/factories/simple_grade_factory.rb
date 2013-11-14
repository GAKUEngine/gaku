FactoryGirl.define do

  factory :simple_grade, class: Gaku::SimpleGrade do
    name 'Math'
    grade 'A+'
    school
    student

    factory :invalid_simple_grade do
      name nil
    end
  end

end
