# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  code           :string(255)
#  faculty_id     :integer
#  syllabus_id    :integer
#  class_group_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :course do
    #association(:syllabus)
    code  "A1"
  end
end
