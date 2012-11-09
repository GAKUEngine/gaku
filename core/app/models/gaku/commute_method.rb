# == Schema Information
#
# Table name: commute_methods
#
#  id                     :integer          not null, primary key
#  details                :text
#  commute_method_type_id :integer
#
module Gaku
	class CommuteMethod < ActiveRecord::Base
		has_one :student
		belongs_to :commute_method_type

		attr_accessible :commute_method_type_id
	end
end
