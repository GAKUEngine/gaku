FactoryGirl.define do

  factory :simple_grade, class: Gaku::SimpleGrade do
    name 'Math'
    grade 'A+'
    school
    student
  end

end
