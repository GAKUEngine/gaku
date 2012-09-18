class School < ActiveRecord::Base

	has_many :campuses

	attr_accessible :name, :is_primary, :slogan, :description, :founded, :principal, :vice_principal, :grades

end