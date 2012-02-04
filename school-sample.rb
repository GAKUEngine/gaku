class Admin::SchoolClass < ActiveRecord::Base
  has_one :syllabus
  #has_one :schedule
  #belongs_to :teacher
  #belongs_to :semester
  has_many :students
  #has_many :homework_outlines
  #has_many :test_outlines
end
