class ExamScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam
  attr_accessible :exam_id, :student_id, :score, :comment 
end