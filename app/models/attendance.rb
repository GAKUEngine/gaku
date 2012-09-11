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

class Attendance < ActiveRecord::Base
	attr_accessible :reason, :description

	belongs_to :attendancable, :polymorphic => true
	belongs_to :student
end
