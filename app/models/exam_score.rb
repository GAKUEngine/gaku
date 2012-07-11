class ExamScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam
  attr_accessible :score, :comment 
end
# == Schema Information
#
# Table name: exam_scores
#
#  id         :integer         not null, primary key
#  score      :float
#  comment    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#  student_id :integer
#

