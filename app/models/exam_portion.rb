class ExamPortion < ActiveRecord::Base
  belongs_to :exam
  has_many :exam_portion_scores
  attr_accessible :name, :max_score, :weight
end