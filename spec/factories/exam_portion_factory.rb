# == Schema Information
#
# Table name: exam_portions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  max_score         :float
#  weight            :float            default(100.0)
#  problem_count     :integer
#  description       :text
#  adjustments       :text
#  dynamic_scoring   :boolean
#  is_master         :boolean          default(FALSE)
#  exam_id           :integer
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :exam_portion do
    name "1st"
    max_score  10 
    weight 4
    problem_count 1
  end
end
