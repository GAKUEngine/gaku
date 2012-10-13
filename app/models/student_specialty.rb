# == Schema Information
#
# Table name: student_specialties
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  specialty_id :integer
#  is_mayor     :boolean          default(TRUE)
#

class StudentSpecialty < ActiveRecord::Base
	belongs_to :specialty
  belongs_to :student

  attr_accessible :student_id, :specialty_id , :is_mayor
end
