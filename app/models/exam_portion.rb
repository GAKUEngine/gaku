class ExamPortion < ActiveRecord::Base
  belongs_to :exam
  has_many :exam_portion_scores
  has_many :files
  has_one :grading_method
  attr_accessible :name, :description, :max_score, :problem_count, :weight, :execution_date, :adjustments, :dynamic_scoring
end
# == Schema Information
#
# Table name: exam_portions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  max_score  :float
#  weight     :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#

