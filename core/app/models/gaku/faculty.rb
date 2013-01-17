module Gaku
	class Faculty < ActiveRecord::Base

    include Addresses, Contacts

	  has_many :roles
	  has_many :students
	  has_many :class_groups
	  has_many :courses
	end
end
