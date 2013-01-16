module Gaku
	class Faculty < ActiveRecord::Base

    include Contactable

	  has_many :roles
	  has_many :students
	  has_many :class_groups
	  has_many :courses
	  has_many :addresses, as: :addressable
	end
end
