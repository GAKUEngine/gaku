# == Schema Information
#
# Table name: assignments
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  max_score         :integer
#  syllabus_id       :integer
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :assignment do
    name "Assignment #1"
    description "Assignment #1 description"
    max_score 6
  end
end
