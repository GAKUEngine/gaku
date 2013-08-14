module Gaku
  class ExternalSchoolRecord < ActiveRecord::Base
    belongs_to :school
    belongs_to :student

    has_many :simple_grades,
             -> { where("school_id = #{self.school_id} AND student_id = #{self.student_id}") },
             class_name: Gaku::SimpleGrade,
             dependent: :destroy

    has_many :achievements

    validates :school_id, :student_id, presence: true
  end
end
