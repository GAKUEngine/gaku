# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer          not null, primary key
#  score           :float
#  exam_portion_id :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ExamPortionScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam_portion
  
  attr_accessible :score, :exam_portion_id, :student_id
end