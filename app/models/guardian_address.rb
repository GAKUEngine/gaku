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

  before_save :ensure_primary_first, :on => :create

  def make_primary    
    self.guardian.guardian_addresses.update_all('is_primary = "false"', "id <> #{self.id}")
    self.is_primary = true
    self.save
  end

  private

  def ensure_primary_first
  	if self.guardian.addresses.blank?
  		self.is_primary = true
  	end
  end
end
