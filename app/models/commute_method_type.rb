# == Schema Information
#
# Table name: commute_method_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class CommuteMethodType < ActiveRecord::Base
	has_many :commute_methods

end
