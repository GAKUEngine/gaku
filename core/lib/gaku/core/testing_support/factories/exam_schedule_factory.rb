FactoryGirl.define do
  factory :exam_schedule, :class => Gaku::ExamSchedule do
    association(:exam_portion)
    association(:schedule)
  end
end
