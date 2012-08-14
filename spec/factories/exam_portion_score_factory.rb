# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer          not null, primary key
#  score           :float
#  exam_portion_id :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :exam_portion_score do
    score 5.90
  end
end
