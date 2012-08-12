# == Schema Information
#
# Table name: exam_schedules
#
#  id              :integer          not null, primary key
#  exam_portion_id :integer
#  schedule_id     :integer
#  course_id       :integer
#

FactoryGirl.define do
  factory :exam_schedule do
    association(:exam_portion)
    association(:schedule)
  end
end
