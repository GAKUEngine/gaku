class Specialty < ActiveRecord::Base
	has_many :student_specialties
  has_many :students, :through => :student_specialties

  attr_accessible :name, :description, :mayor_only
end