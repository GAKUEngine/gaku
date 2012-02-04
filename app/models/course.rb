class Course < ActiveRecord::Base
  has_one :syllabus
  #has_one :schedule
  #has_one :teacher
  has_many :students, :through => :class_enrollement
end
