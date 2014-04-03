FactoryGirl.define do

  factory :student_exam_session, class: Gaku::StudentExamSession do
    student
    exam_session
  end

end
