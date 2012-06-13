class Schedule < ActiveRecord::Base
  has_many :exams
  
  attr_accessible :start, :stop, :repeat 
end