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
module Gaku
  class AssignmentScore < ActiveRecord::Base
    belongs_to :student
    attr_accessible :score, :student_id

    validates_presence_of :score
    validates_associated :student
  end
end