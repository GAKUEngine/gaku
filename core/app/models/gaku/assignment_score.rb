module Gaku
  class AssignmentScore < ActiveRecord::Base
    belongs_to :student
    attr_accessible :score, :student_id

    validates_presence_of :score
    validates_associated :student
  end
end
