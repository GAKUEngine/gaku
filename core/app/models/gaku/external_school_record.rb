module Gaku
  class ExternalSchoolRecord < ActiveRecord::Base
    belongs_to :school
    belongs_to :student
    has_many :simple_grades
    has_many :achievements
    attr_accessible :absences, :attendance_rate, :beginning, :ending, :graduated, :student_id_number, :data
  end
end
