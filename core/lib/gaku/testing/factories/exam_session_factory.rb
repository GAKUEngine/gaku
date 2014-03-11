FactoryGirl.define do

  factory :exam_session, class: Gaku::ExamSession do
    name 'Ruby Session'
    session_time 45
    session_start Time.now
    exam
  end

end
