module Gaku
  class Attendance < ActiveRecord::Base
    belongs_to :attendancable, polymorphic: true
    belongs_to :student
    belongs_to :attendance_type

    validates :student, :attendance_type, presence: true
    validates_associated :attendancable, :student, :attendance_type

    def to_s
      reason
    end
  end
end
