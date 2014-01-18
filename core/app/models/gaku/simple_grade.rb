module Gaku
  class SimpleGrade < ActiveRecord::Base

    belongs_to :student
    belongs_to :simple_grade_type

    validates :student_id, :simple_grade_type_id, :score,  presence: true

    def to_s
      name
    end

  end
end
