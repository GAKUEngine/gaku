module Gaku
  class SimpleGrade < ActiveRecord::Base

  	belongs_to :student
  	belongs_to :school

    attr_accessible :name, :grade, :school_id, :student_id

    validates_presence_of :name, :grade, :school_id, :student_id

    def to_s
      name
    end

  end
end
