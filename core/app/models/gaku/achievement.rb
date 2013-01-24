module Gaku
  class Achievement < ActiveRecord::Base
  	has_many :student_achievement
    has_many :student, :through => :student_achievement

  	belongs_to :school

    attr_accessible :name, :description, :student_id, :school_id

    validates_presence_of :name
    validates_associated :student, :school
  end
end