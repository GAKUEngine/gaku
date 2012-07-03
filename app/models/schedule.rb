class Schedule < ActiveRecord::Base
  has_many :exams
  
  attr_accessible :starting, :ending, :repeat 
end