class ExamPortion < ActiveRecord::Base
  belongs_to :exam
  has_many :exam_portion_scores
end