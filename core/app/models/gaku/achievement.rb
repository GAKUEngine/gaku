module Gaku
  class Achievement < ActiveRecord::Base
  	belongs_to :student
  	belongs_to :school

    attr_accessible :name, :description, :student_id, :school_id

    validates_presence_of :name
    validates_associated :student, :school
  end
end