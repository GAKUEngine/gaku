# == Schema Information
#
# Table name: class_group_enrollments
#
#  id             :integer          not null, primary key
#  class_group_id :integer
#  student_id     :integer
#  seat_number    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :class_group_enrollment do
    association(:class_group)
    association(:student)
    seat_number 5
  end
end
