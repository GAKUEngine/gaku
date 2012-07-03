class Semester < ActiveRecord::Base
  belongs_to :class_group
  
  attr_accessible :starting, :ending
end