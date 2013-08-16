FactoryGirl.define do

  factory :assignment, class: Gaku::Assignment do
    name 'Assignment #1'
    description 'Assignment #1 description'
    max_score 6
    syllabus
    grading_method
  end

end
