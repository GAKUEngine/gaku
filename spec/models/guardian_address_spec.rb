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

require 'spec_helper'

describe GuardianAddress do

  context "validations" do 
    it { should have_valid_factory(:guardian_address) }
    it { should belong_to(:address) }
    it { should belong_to(:guardian) }
  end
  
end
