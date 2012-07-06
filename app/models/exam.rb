class Exam < ActiveRecord::Base
  belongs_to :course
  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  belongs_to :schedule
  belongs_to :course

  attr_accessible :name, :description, :problem_count, :max_score, :execution_date, :weight, :data, :course, :course_id
end