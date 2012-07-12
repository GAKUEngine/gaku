require 'spec_helper'

describe Guardian do

  context "validations" do 
  	it { should have_valid_factory(:guardian) }
    it { should belong_to(:user) }
    it { should belong_to(:profile) }
    it { should have_and_belong_to_many(:addresses) } 
    it { should have_and_belong_to_many(:students) } 
    it { should have_many(:contacts) }
  end
  
end# == Schema Information
#
# Table name: guardians
#
#  id           :integer         not null, primary key
#  relationship :string(255)
#  profile_id   :integer
#  user_id      :integer
#

