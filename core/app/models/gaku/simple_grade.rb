module Gaku
  class SimpleGrade < ActiveRecord::Base
    belongs_to :student
    belongs_to :simple_grade_type

    %i( name school grading_method max_score passing_score ).each do |attribute|
      delegate attribute, to: :simple_grade_type, allow_nil: true, prefix: true
    end

    validates :student_id, :simple_grade_type_id, :score,  presence: true

    def to_s
      simple_grade_type_name
    end
  end
end
