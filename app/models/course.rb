class Course < ActiveRecord::Base
  has_many :course_enrollments
  has_many :students, :through => :course_enrollments
  has_many :exams
  belongs_to :syllabus
  belongs_to :class_group

  accepts_nested_attributes_for :course_enrollments

  attr_accessible :code, :class_group_id 
end
