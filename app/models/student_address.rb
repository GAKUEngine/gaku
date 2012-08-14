# == Schema Information
#
# Table name: student_addresses
#
#  id         :integer          not null, primary key
#  student_id :integer
#  address_id :integer
#  is_primary :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentAddress < ActiveRecord::Base
	belongs_to :student
  belongs_to :address

  attr_accessible :student_id, :address_id, :is_primary

  before_save :ensure_primary_first, :on => :create

  def ensure_primary_first
  	if self.student.addresses.blank?
  		self.is_primary = true
  	end
  end

  def make_primary  	
  	self.student.student_addresses.update_all('is_primary = "false"', "id <> #{self.id}")
  	self.is_primary = true
  	self.save
  end
end
