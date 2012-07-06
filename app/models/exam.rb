class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  belongs_to :schedule


  attr_accessible :name, :description, :problem_count, :max_score, :execution_date, :weight, :data
end