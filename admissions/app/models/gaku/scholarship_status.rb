module Gaku 
  class ScholarshipStatus < ActiveRecord::Base
  	has_many :admissions
  	
    attr_accessible :name
  end
end