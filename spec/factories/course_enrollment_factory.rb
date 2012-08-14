# == Schema Information
#
# Table name: course_enrollments
#
#  id         :integer          not null, primary key
#  student_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :course_enrollment do
    association(:course)
    association(:student)
  end
end
