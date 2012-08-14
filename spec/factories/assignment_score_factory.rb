# == Schema Information
#
# Table name: assignment_scores
#
#  id         :integer          not null, primary key
#  score      :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :assignment_score do
    score 6
  end
end
