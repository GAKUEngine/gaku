module Gaku
  class ExternalSchoolRecord < ActiveRecord::Base
    belongs_to :school
    belongs_to :student

    has_many :simple_grades,
      :class_name => 'Gaku::SimpleGrade',
      :conditions => proc { "school_id = #{self.school_id} AND student_id = #{self.student_id}" },
      :dependent => :destroy

    has_many :achievements

    attr_accessible :absences, :attendance_rate, :beginning, :ending,
                    :graduated, :student_id_number, :data,
                    :school_id, :student_id

    validates_presence_of :school_id, :student_id
  end
end
