module Gaku
  class ExternalSchoolRecord < ActiveRecord::Base
    belongs_to :school
    belongs_to :student

    has_many :simple_grades,
             -> { where("school_id = #{school_id} AND student_id = #{student_id}") },
             class_name: 'Gaku::SimpleGrade',
             dependent: :destroy

    has_many :achievements

    validates :school, :student, presence: true
  end
end
