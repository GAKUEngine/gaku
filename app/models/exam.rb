class Exam < ActiveRecord::Base
  belongs_to :course
  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  belongs_to :schedule

  attr_accessible :name, :problem_count, :max_score, :weight, :data
end