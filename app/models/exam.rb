class Exam < ActiveRecord::Base
  belongs_to :course
  attr_accessible :name, :problem_count, :max_score, :weight, :data
end