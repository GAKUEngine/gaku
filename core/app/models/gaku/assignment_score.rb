module Gaku
  class AssignmentScore < ActiveRecord::Base
    belongs_to :student
    attr_accessible :score, :student_id

    validates :score, presence: true
    validates_associated :student
  end
end
