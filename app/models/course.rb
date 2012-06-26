class Course < ActiveRecord::Base
  has_many :course_enrollments
  has_many :students, :through => :course_enrollments
  accepts_nested_attributes_for :course_enrollments

  attr_accessible :code 
end