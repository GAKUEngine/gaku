# == Schema Information
#
# Table name: commute_method_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#
module Gaku 
	class CommuteMethodType < ActiveRecord::Base
		has_many :commute_methods

		attr_accessible :name

    validates :name, :presence => :true
	end
end
