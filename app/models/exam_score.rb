class ExamScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam
  attr_accessible :score, :comment 
end