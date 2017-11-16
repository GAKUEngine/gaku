module Gaku
  class Attendance < ActiveRecord::Base
    belongs_to :attendancable, polymorphic: true, required: false
    belongs_to :student, required: false
    belongs_to :attendance_type, required: false

    validates :student, :attendance_type, presence: true
    validates_associated :attendancable, :student, :attendance_type

    def to_s
      reason
    end
  end
end
