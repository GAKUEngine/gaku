class ExamPortionScore < ActiveRecord::Base
  belongs_to :exam_portion
  attr_accessible :score
end