class Course < ActiveRecord::Base
  belongs_to :syllabus
  #has_one :schedule
  #has_one :teacher
  has_many :students, :through => :course_enrollement
end
