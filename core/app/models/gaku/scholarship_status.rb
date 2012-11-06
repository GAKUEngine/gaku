module Gaku 
  class ScholarshipStatus < ActiveRecord::Base 
    has_many :students 	
    attr_accessible :name
  end
end