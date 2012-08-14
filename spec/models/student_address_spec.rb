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

require 'spec_helper'

describe StudentAddress do

  context "validations" do 
    it { should have_valid_factory(:student_address) }
    it { should belong_to(:address) }
    it { should belong_to(:student) }
  end
  
end
