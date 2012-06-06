class Student < ActiveRecord::Base
  has_many :course_enrollments
  has_many :courses, :through => :course_enrollments
  #has_and_belongs_to_many :class_groups

  has_many :exams, :through => :exam_scores
  belongs_to :user
  belongs_to :profile

  attr_accessible :name, :address, :phone, :email, :birth, :admitted, :graduated
end