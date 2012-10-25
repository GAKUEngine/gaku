# == Schema Information
#
# Table name: specialties
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  mayor_only  :boolean          default(FALSE)
#
module Gaku
	class Specialty < ActiveRecord::Base
		has_many :student_specialties
	  has_many :students, :through => :student_specialties

	  attr_accessible :name, :description, :mayor_only
	end
end
