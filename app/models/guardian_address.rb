# == Schema Information
#
# Table name: guardian_addresses
#
#  id          :integer          not null, primary key
#  guardian_id :integer
#  address_id  :integer
#  is_primary  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GuardianAddress < ActiveRecord::Base
	belongs_to :guardian
  belongs_to :address

  attr_accessible :guardian_id, :address_id, :is_primary
end
