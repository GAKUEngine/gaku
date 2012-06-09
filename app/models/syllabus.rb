class Syllabus < ActiveRecord::Base
  #has_and_belongs_to_many :courses
  attr_accessible :name, :code, :description, :credits
end