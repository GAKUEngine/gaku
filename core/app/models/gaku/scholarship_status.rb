module Gaku 
  class ScholarshipStatus < ActiveRecord::Base 
    belongs_to :student 	
    attr_accessible :name, :student_id
  end
end