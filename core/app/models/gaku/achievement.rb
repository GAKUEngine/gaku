module Gaku
  class Achievement < ActiveRecord::Base
  	belongs_to :student
  	belongs_to :school

    attr_accessible :name, :description, :student_id, :school_id
  end
end