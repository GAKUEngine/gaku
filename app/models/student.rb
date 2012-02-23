class Student < ActiveRecord::Base
  has_many :courses, :through => :course_enrollements
  has_and_belongs_to_many :class_groups
end
