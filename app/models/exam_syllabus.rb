# == Schema Information
#
# Table name: exam_syllabuses
#
#  id          :integer          not null, primary key
#  exam_id     :integer
#  syllabus_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ExamSyllabus < ActiveRecord::Base
	
	attr_accessible :exam_id

	belongs_to :syllabus
	belongs_to :exam

	validates_presence_of [:exam_id, :syllabus_id]

	validates :syllabus_id, :uniqueness => {:scope => :exam_id, :message => "Already added exam to syllabus!"}



end
