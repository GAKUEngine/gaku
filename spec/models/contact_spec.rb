require 'spec_helper'

describe Contact do

  context "validations" do 
  	it { should have_valid_factory(:contact) }
    it { should belong_to(:contact_type) }
    it { should belong_to(:student) }
  end
  
end# == Schema Information
#
# Table name: contacts
#
#  id              :integer         not null, primary key
#  data            :string(255)
#  details         :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  contact_type_id :integer
#  student_id      :integer
#  guardian_id     :integer
#  faculty_id      :integer
#

