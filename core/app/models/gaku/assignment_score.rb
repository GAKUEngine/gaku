module Gaku
  class AssignmentScore < ActiveRecord::Base
    belongs_to :student

    validates :score, :student, presence: true
    validates_associated :student

    def to_s
      score
    end
  end
end
