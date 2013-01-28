module Gaku
  class Achievement < ActiveRecord::Base
  	has_many :student_achievement
    has_many :student, :through => :student_achievement

  	belongs_to :school

    has_attached_file :badge

    attr_accessible :name, :description, :student_id, :school_id, :authority, :badge

    validates_presence_of :name
    # validates_associated :student, :school

    def to_s
      name
    end

  end
end