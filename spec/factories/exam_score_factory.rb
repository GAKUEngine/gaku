# == Schema Information
#
# Table name: exam_scores
#
#  id         :integer          not null, primary key
#  score      :float
#  comment    :text
#  exam_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :exam_score do
    association(:exam)
    score  6 
    comment "Excellent score"
  end
end
