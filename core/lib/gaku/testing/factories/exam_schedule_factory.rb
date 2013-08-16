FactoryGirl.define do

  factory :exam_schedule, class: Gaku::ExamSchedule do
    exam_portion
    schedule
    course
  end

end
