class Syllabus < ActiveRecord::Base
  has_many :courses
  has_many :assignments
  has_and_belongs_to_many :exams

  attr_accessible :name, :code, :description, :credits, :exams
end
