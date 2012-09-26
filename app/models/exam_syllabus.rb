class ExamSyllabus < ActiveRecord::Base
	
	attr_accessible :exam_id

	belongs_to :syllabus
	belongs_to :exam

	validates_presence_of [:exam_id, :syllabus_id]

	validates :syllabus_id, :uniqueness => {:scope => :exam_id, :message => "Already added exam to syllabus!"}



end