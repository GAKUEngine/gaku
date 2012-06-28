class Syllabus < ActiveRecord::Base
  has_many :courses
  attr_accessible :name, :code, :description, :credits
end
