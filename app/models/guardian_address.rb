class GuardianAddress < ActiveRecord::Base
	belongs_to :guardian
  belongs_to :address

  attr_accessible :guardian_id, :address_id, :is_primary
end