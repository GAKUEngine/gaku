module Gaku
  class Achievement < ActiveRecord::Base
  	has_many :student_achievements
    has_many :students, :through => :student_achievements

    has_attached_file :badge

    attr_accessible :name, :description, :authority, :badge

    validates_presence_of :name
  end
end
