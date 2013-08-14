module Gaku
  class AssignmentScore < ActiveRecord::Base
    belongs_to :student

    validates :score, presence: true
    validates_associated :student
  end
end
