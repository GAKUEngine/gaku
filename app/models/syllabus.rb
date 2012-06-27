class Syllabus < ActiveRecord::Base
  belongs_to :course
  attr_accessible :name, :code, :description, :credits
end
