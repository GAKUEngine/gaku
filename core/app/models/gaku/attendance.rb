# == Schema Information
#
# Table name: attendances
#
#  id                 :integer          not null, primary key
#  reason             :string(255)
#  description        :text
#  attendancable_id   :integer
#  attendancable_type :string(255)
#  student_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
module Gaku
  class Attendance < ActiveRecord::Base

    belongs_to :attendancable, :polymorphic => true
    belongs_to :student
    belongs_to :attendance_type

    attr_accessible :reason, :student_id, :attendance_type_id

    validates_presence_of :reason
    validates_associated :attendancable, :student, :attendance_type

  end
end
