class Course < ActiveRecord::Base
  #belongs_to :syllabus
  #has_one :schedule
  has_many :course_enrollments,:dependent => :destroy
  has_many :students, :through => :course_enrollments
  accepts_nested_attributes_for :course_enrollments

  attr_accessible :code 
end