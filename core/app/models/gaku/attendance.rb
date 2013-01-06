module Gaku
  class Attendance < ActiveRecord::Base

    belongs_to :attendancable, :polymorphic => true
    belongs_to :student
    belongs_to :attendance_type

    attr_accessible :reason, :student_id, :attendance_type_id

    validates_associated :attendancable, :student, :attendance_type

  end
end
