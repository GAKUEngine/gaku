class ClassGroup < ActiveRecord::Base
  has_many :class_group_enrollments
  has_many :students, :through => :class_group_enrollments
  has_many :courses
  has_many :semesters
  
  attr_accessible :name, :grade, :homeroom
end