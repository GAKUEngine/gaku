# == Schema Information
#
# Table name: campuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  school_id  :integer
#  address_id :integer
#  is_master  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Gaku
	class Campus < ActiveRecord::Base

		has_many :contacts
		belongs_to :school
		has_one :address

		attr_accessible :name, :school_id, :address_id, :is_master

		scope :master, lambda { where(:is_master => true) }
    
    validates_presence_of :name

	end
end
