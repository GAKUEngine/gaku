# == Schema Information
#
# Table name: assignment_scores
#
#  id         :integer          not null, primary key
#  score      :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AssignmentScore < ActiveRecord::Base
	belongs_to :student
	attr_accessible :score, :student_id
end
