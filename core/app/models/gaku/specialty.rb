module Gaku
	class Specialty < ActiveRecord::Base
		has_many :student_specialties
	  has_many :students, :through => :student_specialties

    validates :name, :presence => true
	  attr_accessible :name, :description, :major_only

    def to_s
      name
    end
  end
end
